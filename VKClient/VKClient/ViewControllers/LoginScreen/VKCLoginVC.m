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
    __weak typeof(self)weakSelf = self;
    [self.vkcService checkSessionWithCompletionBlock:^(VKAuthorizationState state, NSError *error) {
        if(state == VKAuthorizationAuthorized)
        {
            [weakSelf showNewsScreen];
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

#pragma mark action

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

- (void)showNewsScreen
{
    [self.vkcService userNews];
}

#pragma mark VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result
{
    if (result.token) {
        [self showNewsScreen];
    } else if (result.error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:result.error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)vkSdkUserAuthorizationFailed
{
    [self.vkcService logout];
}

#pragma mark VKSdkUIDelegate

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    VKCaptchaViewController *captchaVC = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [captchaVC presentIn:self.navigationController.topViewController];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}

@end
