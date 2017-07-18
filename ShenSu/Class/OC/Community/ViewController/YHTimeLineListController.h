//
//  YHQAListController.h
//  github:  https://github.com/samuelandkevin
//
//  Created by samuelandkevin on 16/8/29.
//  Copyright © 2016年 HKP. All rights reserved.
//  问答列表

#import <UIKit/UIKit.h>
#import "YHWorkGroup.h"

@interface YHTimeLineListController : UIViewController
@property (nonatomic,assign) NSInteger curPageIndex;
@property (nonatomic,copy) void(^ didSelectedRowBlock)(YHWorkGroup * model);
@end