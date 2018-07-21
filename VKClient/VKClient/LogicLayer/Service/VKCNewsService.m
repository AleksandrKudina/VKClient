//
//  VKCNewsService.m
//  VKClient
//
//  Created by Кудина  on 17.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCNewsService.h"
#import <VKSdk.h>

// все проверки на тип можно убрать, если полность довериться ответу сервера ВК

NSString * const kResponseItems = @"items";

NSString * const kItemsSourceID = @"source_id";
NSString * const kItemsDate = @"date";
NSString * const kItemsPostId = @"post_id";
NSString * const kItemsText = @"text";

NSString * const kItemsAttachments = @"attachments";

NSString * const kItemsAttachmentsType = @"type";
NSString * const kItemsAttachmentsPhoto = @"photo";

    NSString * const kItemsAttachmentsPhotoSizes = @"sizes";
NSString * const kItemsAttachmentsPhotoSizesType = @"p";
NSString * const kItemsAttachmentsPhotoSizesURL = @"src";

NSString * const kProfiles = @"profiles";
NSString * const kProfilesID = @"id";
NSString * const kProfilesFirstName = @"first_name";
NSString * const kProfilesLastName = @"last_name";
NSString * const kProfilesPhoto100 = @"photo_100";

NSString * const kGroups = @"groups";
NSString * const kGroupsID = @"id";
NSString * const kGroupsName = @"name";
NSString * const kGroupsPhoto100 = @"photo_100";

@implementation VKCNewsService

#pragma mark public method


- (void)userNewsWithCompletionBlock:(void(^)(NSArray<VKCNewsEntity*> *news))completionBlock
{
    NSTimeInterval oneHourAway = [[NSDate dateWithTimeIntervalSinceNow:3600] timeIntervalSince1970];
    VKRequest *request = [VKApi requestWithMethod:@"newsfeed.get" andParameters:@{@"filters" : @"post", @"start_time" : @(oneHourAway), @"photo_sizes" : @1}];
    [request executeWithResultBlock:^(VKResponse *response) {
        if([response.json isKindOfClass:[NSDictionary class]])
        {
            NSArray<VKCNewsEntity*>* newsEntity = [self newsListFromResponse:response.json];
            if(completionBlock)
            {
                completionBlock(newsEntity);
            }
        }
    } errorBlock:^(NSError *error) {
        
    }];
}


- (NSArray<VKCNewsEntity*>*)newsListFromResponse:(NSDictionary*)response;
{
    NSMutableArray<VKCNewsEntity*> *newsArray = [NSMutableArray new];
    NSArray *items = response[kResponseItems];
    if([items isKindOfClass:[NSArray class]])
    {
        for(NSDictionary *item in items)
        {
            VKCNewsEntity *news = [VKCNewsEntity new];
            news.sourceID = item[kItemsSourceID];
            news.dateNews = item[kItemsDate];
            news.postID = item[kItemsPostId];
            news.textNews = item[kItemsText];
            
            NSArray *attachments = item[kItemsAttachments];
            if([attachments isKindOfClass:[NSArray class]])
            {
                [self handlingAttachments:attachments forNews:news];
            }
            
            NSArray *profiles = response[kProfiles];
            if([profiles isKindOfClass:[NSArray class]])
            {
                [self handlingProfiles:profiles forNews:news];
            }
            
            NSArray *groups = response[kGroups];
            if([groups isKindOfClass:[NSArray class]])
            {
                [self handlingGroups:groups forNews:news];
            }
            [newsArray addObject:news];
        }
    }
    return [newsArray copy];
}

#pragma mark private method

- (void)handlingAttachments:(NSArray*)attachments forNews:(VKCNewsEntity*)news
{
    NSDictionary *attachment = attachments.firstObject;
    NSString *attachmentType = attachment[kItemsAttachmentsType];
    if([attachmentType isEqualToString:@"photo"])
    {
        NSDictionary *attachmentPhoto = attachment[kItemsAttachmentsPhoto];
        if([attachmentPhoto isKindOfClass:[NSDictionary class]])
        {
            NSArray *sizes = attachmentPhoto[kItemsAttachmentsPhotoSizes];
            if([sizes isKindOfClass:[NSArray class]])
            {
                NSUInteger index = [sizes indexOfObjectPassingTest:^BOOL(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if([obj[kItemsAttachmentsType] isEqualToString:kItemsAttachmentsPhotoSizesType])
                    {
                        *stop = YES;
                        return YES;
                    }
                    return NO;
                }];
                if (index != NSNotFound)
                {
                    NSDictionary *pSize = sizes[index];
                    NSString *urlString = pSize[kItemsAttachmentsPhotoSizesURL];
                    if([urlString isKindOfClass:[NSString class]])
                    {
                        news.imageNewsURL = [NSURL URLWithString:urlString];
                    }
                }
            }
        }
    }
}

- (void)handlingProfiles:(NSArray*)profiles forNews:(VKCNewsEntity*)news
{
    NSUInteger index = [profiles indexOfObjectPassingTest:^BOOL(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *profileID = obj[kProfilesID];
        if(profileID.floatValue == news.sourceID.floatValue)
        {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    if (index != NSNotFound)
    {
        NSDictionary *profile = profiles[index];
        NSString *firstName = profile[kProfilesFirstName];
        NSString *lastName = profile[kProfilesLastName];
        if([firstName isKindOfClass:[NSString class]] && [lastName isKindOfClass:[NSString class]])
        {
            news.newsSourceName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        }
        NSString *URLString = profile[kProfilesPhoto100];
        if([URLString isKindOfClass:[NSString class]])
        {
            news.avatarImageURL = [NSURL URLWithString:URLString];
        }
    }
}

- (void)handlingGroups:(NSArray*)groups forNews:(VKCNewsEntity*)news
{
    NSUInteger index = [groups indexOfObjectPassingTest:^BOOL(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *groupID = obj[kGroupsID];
        if(groupID.floatValue * -1 == news.sourceID.floatValue)
        {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    if (index != NSNotFound)
    {
        NSDictionary *group = groups[index];
        NSString *name = group[kGroupsName];
        if([name isKindOfClass:[NSString class]])
        {
            news.newsSourceName = name;
        }
        NSString *URLString = group[kGroupsPhoto100];
        if([URLString isKindOfClass:[NSString class]])
        {
            news.avatarImageURL = [NSURL URLWithString:URLString];
        }
    }
}

@end
