//
//  HGJChattingModel.h
//  HGJChatting
//
//  Created by 胡古斤 on 16/7/9.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    MessageTypeMine = 0,
    MessageTypeOther
    
}MessageType;

@interface HGJChattingModel : NSObject

/** cell高度 */
@property (assign, nonatomic) CGFloat height;


/** 消息 */
@property (strong, nonatomic) NSString * text;

/** 时间 */
@property (strong, nonatomic) NSString * time;
@property (assign, nonatomic) BOOL timeHidden;

/** 消息类型 */
@property (assign, nonatomic) MessageType type;


+ (instancetype)modelWithDic: (NSDictionary *)dic;

+ (instancetype)modelWithText: (NSString *)text;


/** 2016.9.13新增 输入删除功能  根据model生成字典 */
+ (NSDictionary *)dicFromModel: (HGJChattingModel *)model;

@end
