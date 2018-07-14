//
//  VKCLoginScreenVC.m
//  VKClient
//
//  Created by Кудина  on 14.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCLoginVC.h"
#import "VKCService.h"

@interface VKCLoginVC () <VKSdkDelegate, VKSdkUIDelegate>
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) VKCService *vkcService;
@end

@implementation VKCLoginVC

#pragma mark lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self.vkcService initializeVKSdkWith:self];
    [self.vkcService checkSessionWithCompletionBlock:^(VKAuthorizationState state, NSError *error) {
        if(state == VKAuthorizationAuthorized)
        {
            
        }
        else if (error)
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

#pragma mark property

- (VKCService*)vkcService
{
    if(!_vkcService)
    {
        _vkcService = [VKCService new];
    }
    return _vkcService;
}

#pragma mark public method

- (IBAction)login:(id)sender
{
    [self.vkcService login];
}

#pragma mark private method

- (void)setup
{
    self.title = @"Authorization";
    [self.loginButton setTitle:@"Login with VK" forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 5.;
}

#pragma mark VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)vkSdkUserAuthorizationFailed
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

#pragma mark VKSdkUIDelegate

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
