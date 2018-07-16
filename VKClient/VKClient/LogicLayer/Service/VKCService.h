//
//  VKService.h
//  VKClient
//
//  Created by Кудина  on 14.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VKSdk.h>

@interface VKCService : NSObject

- (void)initializeVKSdkWith:(id<VKSdkUIDelegate, VKSdkDelegate>)delegate;
- (void)checkSessionWithCompletionBlock:(void (^)(VKAuthorizationState state, NSError *error))completionBlock;
- (void)login;
- (void)logout;
- (void)userNews;

@end
