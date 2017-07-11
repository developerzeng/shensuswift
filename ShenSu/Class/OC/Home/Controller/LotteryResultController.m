//
//  LotteryResultController.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryResultController.h"
#import "LotteryDetail.h"
#import "LotteryItemViewCell.h"
#import "LotteryResultCell.h"

@interface LotteryResultController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *topLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *topRightLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCollectionHCons;
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCollectionHCons;
@property (weak, nonatomic) IBOutlet UICollectionView *bottomCollectionView;

@property (nonatomic,strong)NSArray *numbers;
@property (nonatomic,assign)NSInteger details;
@property (nonatomic,strong)NSMutableArray *texts;
@end

@implementation LotteryResultController

static NSString *const LotteryItemViewCellID = @"LotteryItemViewCell";
static NSString *const LotteryResultCellID = @"LotteryResultCell";


- (NSMutableArray *)texts{
    if (_texts == nil) {
        _texts = [NSMutableArray array];
    }
    return _texts;
}

- (NSArray *)numbers {
    if (_numbers == nil) {
        _numbers = [NSArray array];
    }
    return _numbers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.kind.lottery_name;
    
//    self.topLeftLabel.text = [NSString stringWithFormat:@"%@期开奖结果",self.lottery.expect];
//    self.topRightLabel.text = [NSDate timestampToDateStr:self.lottery.opentimestamp withFormat:@"MM月dd日开奖"];
//    
//   
//    
//    [self.topCollectionView registerNib:[UINib nibWithNibName:@"LotteryItemViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryItemViewCellID];
////    [self.bottomCollectionView registerNib:[UINib nibWithNibName:@"LotteryResultCell" bundle:nil] forCellWithReuseIdentifier:LotteryResultCellID];
//    
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.topCollectionView.collectionViewLayout;
//    layout.minimumLineSpacing = 5;
//    layout.itemSize = CGSizeMake(kItemWH, kItemWH);
//    
//    self.numbers = [self.lottery.opencode componentsSeparatedByString:@","];
//    if (self.numbers.count <=7) {
//        self.topCollectionHCons.constant = kItemWH;
//    }else if (self.numbers.count >7 && self.numbers.count <= 14){
//        self.topCollectionHCons.constant = kItemWH * 2 + 10;
//    }
//    
//    self.details = (self.lottery.detail.count+1) * 3 + 4;
//    
//    UICollectionViewFlowLayout *layout2 = (UICollectionViewFlowLayout*)self.bottomCollectionView.collectionViewLayout;
//    layout2.minimumLineSpacing = 1;
//    layout2.minimumInteritemSpacing = 1;
//    layout2.itemSize = CGSizeMake(kResultWH, 30);
//    NSArray *arr2 = self.lottery.detail;
//    self.bottomCollectionHCons.constant = (arr2.count + 3 )*30 +  arr2.count + 2 + 2;
//    layout2.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
//    
//    
//    [self.texts addObject:@"奖级"];
//    [self.texts addObject:@"注数"];
//    [self.texts addObject:@"奖金"];
//    for (LotteryDetail *detail in self.lottery.detail) {
//        [self.texts addObject:detail.name];
//        [self.texts addObject:detail.count];
//        [self.texts addObject:detail.money];
//    }
//    [self.texts addObject:@"销售额"];
//    [self.texts addObject:self.lottery.sales];
//    [self.texts addObject:@"奖池"];
//    [self.texts addObject:self.lottery.balance];
}



//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
////    if (collectionView == self.bottomCollectionView) {
////        if (indexPath.item == self.details - 3) {
////            return CGSizeMake(kResultWH*2 +1, 30);
////        }else if (indexPath.item == self.details - 1) {
////            return CGSizeMake(kResultWH*2 +1, 30);
////        }
////        return CGSizeMake(kResultWH, 30);
////    }
// //   return CGSizeMake(kItemWH, kItemWH);
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //if (collectionView == self.topCollectionView) {
        return self.numbers.count;
//    }
//    return self.details;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //if (collectionView == self.topCollectionView) {
        LotteryItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryItemViewCellID forIndexPath:indexPath];
        cell.number = self.numbers[indexPath.row];
        cell.lottery = self.lottery;
    
//        if ([self.lottery.name isEqualToString:@"双色球"] || [self.lottery.name isEqualToString:@"七乐彩"]) {
//            if (indexPath.item == self.numbers.count-1) {
//                [cell.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:21 green:128 blue:218]];
//            }
//        }else if ([self.lottery.name isEqualToString:@"大乐透"]) {
//            if ((indexPath.item == self.numbers.count-1) || (indexPath.item == self.numbers.count-2)) {
//                [cell.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:21 green:128 blue:218]];
//            }
//        }
    
        return cell;
//    }
//    LotteryResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryResultCellID forIndexPath:indexPath];
//    cell.text = self.texts[indexPath.item];
//    return cell;
}

- (IBAction)gotoWebAction:(id)sender {
    NSLog(@"url - %@",self.kind.lottery_image_url);
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[FXTools getLotteryURL:self.kind.lottery_name]]];
}



@end
