//
//  FXCollectionViewCell.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXLoopViewCell.h"


@interface FXLoopViewCell()
@property (nonatomic,weak)UIImageView *iconView;
@end

@implementation FXLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.iconView = imageView;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
}

- (void)setItem:(LotteryAd *)item{
    _item = item;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.ImgUrl]placeholderImage:[UIImage imageNamed:@"empty_picture"]];
}

@end
