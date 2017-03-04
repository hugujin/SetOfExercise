//
//  HGJ_StateCell.h
//  mytest
//
//  Created by 胡古斤 on 16/7/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGJ_StateModel.h"

@interface HGJ_StateCell : UITableViewCell

/** cell数据源 */
@property (strong, nonatomic) HGJ_StateModel * model;

+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
