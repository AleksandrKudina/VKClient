//
//  VKCNewsDataSource.m
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCNewsDataSource.h"
#import "VKCNewsCell.h"

@implementation VKCNewsDataSource

#pragma mark property

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setup];
    [_tableView reloadData];
}

- (void)setNews:(NSArray *)news
{
    _news = news;
    [_tableView reloadData];
}

#pragma mark private method

- (void)setup
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VKCNewsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VKCNewsCell class])];
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    VKCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VKCNewsCell class])];
    [cell configureWithNews:self.news[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}

@end
