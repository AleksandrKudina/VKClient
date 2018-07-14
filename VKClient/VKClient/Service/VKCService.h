//
//  VKService.h
//  VKClient
//
//  Created by Кудина  on 14.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VK_ios_sdk/VKSdk.h>

@interface VKCService : NSObject

- (void)initializeVKSdkWith:(id<VKSdkUIDelegate, VKSdkDelegate>)delegate;
- (void)checkSessionWithCompletionBlock:(void (^)(VKAuthorizationState state, NSError *error))completionBlock;
- (void)login;

@end
