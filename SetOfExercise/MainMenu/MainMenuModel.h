//
//  MainMenuModel.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainMenuModel : NSObject

/** 内容 */
@property (strong, nonatomic) NSString * content;

/** 说明 */
@property (strong, nonatomic) NSString * details;

/** 控制器名称 */
@property (strong, nonatomic) NSString * className;

+ (instancetype)modelWithDic: (NSDictionary *)dic;

@end
