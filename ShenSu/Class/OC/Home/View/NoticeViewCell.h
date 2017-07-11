//
//  NoticeViewCell.h
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXNoticeInfo.h"

@protocol NoticeViewCellDelegate <NSObject>

- (void)noticeViewCell:(UISwitch *)switchBtn andIndexPath:(NSIndexPath *)indexPath;
@end

@interface NoticeViewCell : UITableViewCell

@property(nonatomic,weak)id <NoticeViewCellDelegate> delegate;

@property (nonatomic,strong)NSIndexPath * indexPath;

@property (nonatomic,strong)FXNoticeInfo *info;

@end
