//
//  HGJChattingCell.h
//  HGJChatting
//
//  Created by 胡古斤 on 16/7/9.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGJChattingModel.h"

@interface HGJChattingCell : UITableViewCell

/** Cell的数据 */
@property (strong, nonatomic) HGJChattingModel * model;



/** 新增  2016.9.13 */

/** 会话角标 */
@property (strong, nonatomic) NSIndexPath * index;

/** 回调删除事件 */
@property (strong, nonatomic) void (^delAction)( NSIndexPath * index );

/** 新增  2016.9.13 */



+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
