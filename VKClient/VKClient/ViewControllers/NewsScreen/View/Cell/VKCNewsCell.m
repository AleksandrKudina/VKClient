//
//  VKCNewsCell.m
//  VKClient
//
//  Created by Кудина  on 16.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import "VKCNewsCell.h"

@interface VKCNewsCell ()
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateNewsLabel;
@property (nonatomic, weak) IBOutlet UITextView *newsTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightImageView;
@end

@implementation VKCNewsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

@end
