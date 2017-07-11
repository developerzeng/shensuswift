//
//  LotteryViewCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryViewCell.h"
#import "LotteryItemViewCell.h"



@interface LotteryViewCell()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lotteryName;
@property (weak, nonatomic) IBOutlet UILabel *periods;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHCons;

@property (nonatomic,strong)NSArray *numbers;

@end

@implementation LotteryViewCell

static NSString *const LotteryItemViewCellID = @"LotteryItemViewCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryItemViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryItemViewCellID];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 5;
 //   layout.itemSize = CGSizeMake(kItemWH, kItemWH);
}


- (void)setLottery:(Lottery *)lottery{
    _lottery = lottery;
    self.lotteryName.text =lottery.name;
    
//    if (lottery.opentimestamp) {
//        NSString *time = [NSDate timestampToDateStr:lottery.opentimestamp withFormat:@"MM月dd日开奖"];
//        self.periods.text = [NSString stringWithFormat:@"第%@期 %@",lottery.expect,time];
//    }else{
//        NSString *time = [NSDate timestampToDateStr:lottery.open_time withFormat:@"MM月dd日开奖"];
//        self.periods.text = [NSString stringWithFormat:@"第%@期 %@",lottery.issue,time];
//    }
    
    
//    
//    if (lottery.opencode) {
//        self.numbers = [lottery.opencode componentsSeparatedByString:@","];
//        if (self.numbers.count <=7) {
//            self.collectionViewHCons.constant = kItemWH;
//        }else if (self.numbers.count >7 && self.numbers.count <= 14){
//            self.collectionViewHCons.constant = kItemWH * 2 + 10;
//        }
//    }else{
//        self.numbers = [lottery.result componentsSeparatedByString:@","];
//        if (self.numbers.count <=7) {
//            self.collectionViewHCons.constant = kItemWH;
//        }else if (self.numbers.count >7 && self.numbers.count <= 14){
//            self.collectionViewHCons.constant = kItemWH * 2 + 10;
//        }
//    }
//    

    
 //   [self.contentView layoutIfNeeded];
    
   // [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numbers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LotteryItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryItemViewCellID forIndexPath:indexPath];
    cell.number = self.numbers[indexPath.item];
    cell.lottery = self.lottery;
    if ([self.lottery.name isEqualToString:@"双色球"] || [self.lottery.name isEqualToString:@"七乐彩"]) {
//        if (indexPath.item == self.numbers.count-1) {
//            [cell.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:21 green:128 blue:218]];
//        }
    }else if ([self.lottery.name isEqualToString:@"大乐透"]) {
        if ((indexPath.item == self.numbers.count-1) || (indexPath.item == self.numbers.count-2)) {
 //           [cell.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:21 green:128 blue:218]];
        }
    }
    return cell;
}


@end
