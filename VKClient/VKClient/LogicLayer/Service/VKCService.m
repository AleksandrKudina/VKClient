//
//  VKService.m
//  VKClient
//
//  Created by Кудина  on 14.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCService.h"

@interface VKCService ()
@property (nonatomic, strong) NSArray *SCOPE;
@end

@implementation VKCService

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _SCOPE = @[@"wall", @"friends"];
    }
    return self;
}

- (void)initializeVKSdkWith:(id<VKSdkUIDelegate, VKSdkDelegate>)delegate
{
    [[VKSdk initializeWithAppId:@"6633254"] registerDelegate:delegate];
    [[VKSdk instance] setUiDelegate:delegate];
}

- (void)checkSessionWithCompletionBlock:(void (^)(VKAuthorizationState, NSError *error))completionBlock
{
    [VKSdk wakeUpSession:self.SCOPE completeBlock:completionBlock];
}

- (void)login
{
    [VKSdk authorize:self.SCOPE];
}

- (void)logout
{
    [VKSdk forceLogout];
}

- (void)userNews
{
    NSTimeInterval oneHourAway = [[NSDate dateWithTimeIntervalSinceNow:3600] timeIntervalSince1970];
    VKRequest *request = [VKApi requestWithMethod:@"newsfeed.get" andParameters:@{@"filters" : @"post", @"start_time" : @(oneHourAway)}];
    [request executeWithResultBlock:^(VKResponse *response) {
        
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
