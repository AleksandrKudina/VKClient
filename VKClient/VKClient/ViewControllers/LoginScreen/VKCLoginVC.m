//
//  VKCLoginScreenVC.m
//  VKClient
//
//  Created by Кудина  on 14.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCLoginVC.h"
#import "VKCService.h"
#import "VKCLoginRouter.h"

@interface VKCLoginVC () <VKSdkDelegate, VKSdkUIDelegate>
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) VKCService *vkcService;
@property (nonatomic, strong) VKCLoginRouter *router;
@end

@implementation VKCLoginVC

#pragma mark lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.router = [VKCLoginRouter new];
    [self setup];
    [self.vkcService initializeVKSdkWith:self];
    [self checkSession];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    if(self.vkcService.isLoggedIn)
    {
        [self showNewsScreen];
    }
    else
    {
        [self.vkcService login];
    }
}

#pragma mark private method

- (void)setup
{
    [self.loginButton setTitle:@"Login with VK" forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 5.;
}

- (void)checkSession
{
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

- (void)showNewsScreen
{
    [self.router showNewsVCFromSourceVC:self];
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
