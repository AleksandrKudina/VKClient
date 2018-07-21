//
//  VKCNewsCell.m
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCNewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface VKCNewsCell ()
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UIImageView *newsImage;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateNewsLabel;
@property (nonatomic, weak) IBOutlet UITextView *newsTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightImageView;
@property (nonatomic, strong) VKCNewsEntity *newsEntity;
@end

@implementation VKCNewsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark public method

- (void)configureWithNews:(VKCNewsEntity*)newsEntity
{
    self.newsEntity = newsEntity;
    [self setup];
}

#pragma mark private method

- (void)setup
{
    self.titleLabel.text = self.newsEntity.newsSourceName;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.newsEntity.dateNews.longLongValue];
    self.dateNewsLabel.text = [NSString stringWithFormat:@"%@", date];
    self.newsTextView.text = self.newsEntity.textNews;
    if(self.newsEntity.avatarImageURL.absoluteString.length > 0)
    {
        [self.avatarImageView sd_setImageWithURL:self.newsEntity.avatarImageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if([imageURL isEqual:self.newsEntity.imageNewsURL] && image !=nil)
            {
                self.avatarImageView.image = image;
            }
        }];
    }
    if(self.newsEntity.imageNewsURL.absoluteString.length > 0)
    {
        [self.newsImage sd_setImageWithURL:self.newsEntity.imageNewsURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if([imageURL isEqual:self.newsEntity.imageNewsURL] && image !=nil)
            {
                self.newsImage.image = image;
            }
        }];
    }
    else
    {
        self.heightImageView.constant = 0.;
    }
}



@end
