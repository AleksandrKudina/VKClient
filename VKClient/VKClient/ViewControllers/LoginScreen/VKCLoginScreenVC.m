//
//  VKCLoginScreenVC.m
//  VKClient
//
//  Created by Кудина  on 14.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCLoginScreenVC.h"
#import <VK_ios_sdk/VKSdk.h>

@interface VKCLoginScreenVC () <VKSdkDelegate, VKSdkUIDelegate>

@end

@implementation VKCLoginScreenVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}



- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result
{
    
}

- (void)vkSdkUserAuthorizationFailed
{
   
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
   
}



@end
