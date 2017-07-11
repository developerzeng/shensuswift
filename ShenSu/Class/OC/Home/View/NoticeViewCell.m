//
//  NoticeViewCell.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "NoticeViewCell.h"

@interface NoticeViewCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

@end

@implementation NoticeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)switchAction:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(noticeViewCell:andIndexPath:)]) {
        [self.delegate noticeViewCell:sender andIndexPath:self.indexPath];
    }
}


- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}


- (void)setInfo:(FXNoticeInfo *)info{
    _info = info;
    NSLog(@"name = %@",info.name);
    self.leftLabel.text = info.name;
    [self.switchBtn setOn:info.status animated:NO];
}


@end
