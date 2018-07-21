//
//  VKCNewsDataSource.h
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VKCNewsEntity.h"

@interface VKCNewsDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<VKCNewsEntity*> *news;
@end
