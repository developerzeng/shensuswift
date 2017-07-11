//
//  FootBallLivewCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/15.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FootBallLivewCell.h"
//#import "FXVerticalBtn.h"
//#import "UIButton+WebCache.h"

@interface FootBallLivewCell()
@property (weak, nonatomic) IBOutlet UILabel *NoLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
//@property (weak, nonatomic) IBOutlet FXVerticalBtn *HNBtn;
//@property (weak, nonatomic) IBOutlet FXVerticalBtn *GNBtn;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;


@end

@implementation FootBallLivewCell{
  
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionBtn.titleLabel.numberOfLines = 0;
    self.collectionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
   
}


- (IBAction)collectionBtnClick:(UIButton *)sender {
    NSLog(@"%d",sender.isSelected);
    
    sender.selected = !sender.isSelected;
    
    self.live.isCollection = sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(FootBallLivewCellCollection:andSelected:)]) {
        [self.delegate FootBallLivewCellCollection:self andSelected:sender.selected];
    }
}

- (void)setLive:(FXFootBallLive *)live{
    _live = live;
    
    self.NoLabel.text = [NSString stringWithFormat:@"%@%@",live.No,live.Sclass];
    self.DateLabel.text = [live.Date substringWithRange:NSMakeRange(11, 5)];
//    [self.HNBtn setTitle:live.HN forState:UIControlStateNormal];
//    [self.GNBtn setTitle:live.GN forState:UIControlStateNormal];
    if (live.HHS) {
        [self.collectionBtn setBackgroundImage:[[UIImage alloc]init] forState:UIControlStateNormal];
        [self.collectionBtn setBackgroundImage:[[UIImage alloc]init] forState:UIControlStateSelected];
        NSString *nam1 = [NSString stringWithFormat:@"%@:%@",live.HS,live.GS];
        NSString *nam2 = [NSString stringWithFormat:@"(半%@:%@)",live.HHS,live.AHS];
        NSString *lastName = [NSString stringWithFormat:@"%@\n%@",nam1,nam2];
        [self.collectionBtn setTitle:lastName forState:UIControlStateNormal];
       
   //     [self.collectionBtn setAttributedTitle:[NSString renderText:lastName targetStr:nam1 font:kFont(13) andColor:[UIColor redColor]] forState:UIControlStateNormal];
        self.resultLabel.text = @"完场";
    }else{
        [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_LiveScores_attention"] forState:UIControlStateNormal];
        [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_LiveScores_attention_sel"] forState:UIControlStateSelected];
        self.resultLabel.text = @"未开赛";
        self.collectionBtn.selected = self.live.isCollection;
        [self.collectionBtn setTitle:@"" forState:UIControlStateNormal];
        [self.collectionBtn setAttributedTitle:nil forState:UIControlStateNormal];
    }
  
  //  [self.HNBtn sd_setImageWithURL:[NSURL URLWithString:live.HTI] forState:UIControlStateNormal];
    
   
  //  [self.GNBtn sd_setImageWithURL:[NSURL URLWithString:live.GTI] forState:UIControlStateNormal];
    
}

@end
