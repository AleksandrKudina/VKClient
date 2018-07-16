//
//  VKCNewsVC.m
//  VKClient
//
//  Created by Кудина  on 15.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCNewsVC.h"
#import "VKCNewsDataSource.h"

@interface VKCNewsVC ()
@property (nonatomic, weak) IBOutlet UITableView *newsTableView;
@property (nonatomic, strong) VKCNewsDataSource *dataSource;
@end

@implementation VKCNewsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [VKCNewsDataSource new];
    self.newsTableView.dataSource = self.dataSource;
    self.dataSource.tableView = self.newsTableView;
    
}



@end
