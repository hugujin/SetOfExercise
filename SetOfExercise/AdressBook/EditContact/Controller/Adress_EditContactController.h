//
//  Adress_EditContactController.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/13.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Adress_ContactModel;

@interface Adress_EditContactController : UIViewController

/** 联系人 */
@property (nonatomic, strong) Adress_ContactModel * model;

/** 回调函数用来归档 */
@property (nonatomic, strong) void(^editContactBlock)();

@end
