//
//  VKCNewsEntity.h
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IVKCNewsEntity
@property (nonatomic, strong) NSNumber *sourceID;
@property (nonatomic, strong) NSNumber *dateNews;
@property (nonatomic, strong) NSNumber *postID;
@property (nonatomic, strong) NSURL *avatarImageURL;
@property (nonatomic, strong) NSURL *imageNewsURL;
@property (nonatomic, copy) NSString *newsSourceName;
@property (nonatomic, copy) NSString *textNews;
@end

@interface VKCNewsEntity : NSObject <IVKCNewsEntity>

@end
