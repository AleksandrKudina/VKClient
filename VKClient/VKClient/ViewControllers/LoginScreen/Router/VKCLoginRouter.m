//
//  VKCLoginRouter.m
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCLoginRouter.h"
#import "VKCNewsVC.h"

@interface VKCLoginRouter () <YDRouter>
@end

@implementation VKCLoginRouter

- (void)showNewsVCFromSourceVC:(UIViewController *)sourceVC
{
    YDPreparationBlock preparationBlock =  ^void(UIStoryboardSegue *segue) {
        VKCNewsVC *destinationViewController = segue.destinationViewController;
        destinationViewController.router = self;
    };
    
    [sourceVC performSegueWithIdentifier:@"showNewsVC" sender:self preparationBlock:preparationBlock];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *sourceViewController = segue.sourceViewController;
    YDPreparationBlock block = [sourceViewController preparationBlockForSegue:segue];
    
    if (block)
    {
        block(segue);
    }
}

@end
