//
//  HGJ_StateModel.h
//  mytest
//
//  Created by 胡古斤 on 16/7/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGJ_StateModel : NSObject

/** 文本消息 */
@property (strong, nonatomic) NSString * text;

/** 头像 */
@property (strong, nonatomic) NSString * icon;

/** 昵称 */
@property (strong, nonatomic) NSString * name;

/** 图片内容 */
@property (strong, nonatomic) NSString * picture;

/** 是否会员 */
@property (assign, nonatomic, getter = isVip) BOOL vip;

/** cell高度 */
@property (assign, nonatomic) double height;

+ (instancetype)stateModel: (NSDictionary *)cellDic;

@end
