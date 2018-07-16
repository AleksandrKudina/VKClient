//
//  VKCNewsVC.h
//  VKClient
//
//  Created by Кудина  on 15.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKCNewsEntity.h"

@interface VKCNewsVC : UIViewController
- (void)configureWithNews:(NSArray<VKCNewsEntity*>*)news;
@end
