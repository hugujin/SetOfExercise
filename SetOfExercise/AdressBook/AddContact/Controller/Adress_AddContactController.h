//
//  Adress_AddContactController.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/13.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Adress_ContactModel;

@interface Adress_AddContactController : UIViewController

@property (strong, nonatomic) void(^addContactBlock)(Adress_ContactModel * model);

@end
