//
//  HGJ_StateCell.m
//  mytest
//
//  Created by 胡古斤 on 16/7/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "HGJ_StateCell.h"

@interface HGJ_StateCell ()

@property (weak, nonatomic) IBOutlet UIImageView *protrait;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@end

@implementation HGJ_StateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.message.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"cell";
    HGJ_StateCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HGJ_StateCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setModel:(HGJ_StateModel *)model {

    _model = model;
    
    self.protrait.image = [UIImage imageNamed:self.model.icon];
    
    if (_model.picture) {
        self.contentImage.hidden = false;
        self.contentImage.image = [UIImage imageNamed:self.model.picture];
    }else {
        self.contentImage.hidden = YES;
    }
    
    self.vip.hidden = !self.model.isVip;
    if (_model.isVip) {
        self.message.textColor = [UIColor orangeColor];
        self.nickname.textColor = [UIColor orangeColor];
    }else {
        self.message.textColor = [UIColor blackColor];
        self.nickname.textColor = [UIColor blackColor];
    }
    
    self.nickname.text = self.model.name;
    self.message.text = self.model.text;
    
    //强制布局，算出高度，不能用self.contentView去计算。因为这个高度会在表视图代理方法里面才会被计算出来。
    [self layoutIfNeeded];
    
    if (_model.picture) {
        _model.height = CGRectGetMaxY(_contentImage.frame) + 10;
    }else {
        _model.height = CGRectGetMaxY(_message.frame) + 10;
    }
}

@end
