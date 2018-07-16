//
//  VKCNewsCell.h
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKCNewsEntity.h"

@interface VKCNewsCell : UITableViewCell
- (void)configureWithNews:(VKCNewsEntity*)newsEntity;
@end
