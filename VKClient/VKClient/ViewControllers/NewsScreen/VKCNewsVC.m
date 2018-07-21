//
//  VKCNewsVC.m
//  VKClient
//
//  Created by Кудина  on 15.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCNewsVC.h"
#import "VKCNewsDataSource.h"
#import "VKCNewsService.h"

@interface VKCNewsVC ()
@property (nonatomic, weak) IBOutlet UITableView *newsTableView;
@property (nonatomic, strong) VKCNewsDataSource *dataSource;
@property (nonatomic, strong) NSArray<VKCNewsEntity*> *news;
@property (nonatomic, strong) VKCNewsService *newsService;
@end

@implementation VKCNewsVC

#pragma mark lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [VKCNewsDataSource new];
    self.newsTableView.dataSource = self.dataSource;
    self.dataSource.tableView = self.newsTableView;
    __weak typeof(self) weakSelf = self;
    [self.newsService userNewsWithCompletionBlock:^(NSArray<VKCNewsEntity *> *news) {
        weakSelf.dataSource.news = news;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (VKCNewsService *)newsService
{
    if(_newsService == nil)
    {
        _newsService = [VKCNewsService new];
    }
    return _newsService;
}

@end
