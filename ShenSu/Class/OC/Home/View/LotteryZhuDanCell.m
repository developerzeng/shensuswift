//
//  LotteryZhuDanCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/2.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryZhuDanCell.h"
#import "LotteryItemViewCell.h"
#import "Lottery.h"

@interface LotteryZhuDanCell()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHCons;

@end
static NSString *const LotteryItemViewCell22ID = @"LotteryItemViewCell";
@implementation LotteryZhuDanCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryItemViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryItemViewCell22ID];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 5;
 //   layout.itemSize = CGSizeMake(kItemWH, kItemWH);
}
- (IBAction)deletedAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(LotteryZhuDanCellDeletedCell:)]) {
        [self.delegate LotteryZhuDanCellDeletedCell:self];
    }
}



- (void)setBoards:(NSMutableArray *)boards{
    _boards = boards;
//    if (self.boards.count <=7) {
//        self.collectionViewHCons.constant = kItemWH;
//    }else if (self.boards.count >7 && self.boards.count <= 14){
//        self.collectionViewHCons.constant = kItemWH * 2 + 10;
//    }
    
    [self.collectionView reloadData];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.boards.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LotteryItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryItemViewCell22ID forIndexPath:indexPath];
//    cell.board = self.boards[indexPath.item];
    
    return cell;
}


@end
