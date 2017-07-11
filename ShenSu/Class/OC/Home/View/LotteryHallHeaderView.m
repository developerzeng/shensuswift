//
//  LotteryHallHeaderView.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/23.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryHallHeaderView.h"
#import "FXLoopViewCell.h"
#import "FXLoopViewCell.h"

@interface LotteryHallHeaderView()<UICollectionViewDelegate,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak,nonatomic)NSTimer *timer;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@end

static NSString *const collectionView1ID = @"collectionViewID";
@implementation LotteryHallHeaderView

- (void)awakeFromNib {
     [super awakeFromNib];
     [self.collectionView registerClass:[FXLoopViewCell class] forCellWithReuseIdentifier:collectionView1ID];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.layout.itemSize = self.bounds.size;
}

- (void)setAdItems:(NSArray *)adItems {
    _adItems = adItems;
    self.layout.itemSize = self.bounds.size;
    [self.collectionView reloadData];
    
    if (adItems.count) {
        self.pageControl.numberOfPages = self.adItems.count;
        self.pageControl.hidden = NO;
        self.pageControl.currentPage = 0;
       [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.adItems.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [self addTimer];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.adItems.count *3;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FXLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionView1ID forIndexPath:indexPath];
    cell.item = self.adItems[indexPath.item % self.adItems.count];
    return cell;
}

//手动滚动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    if (page == 0) {  //滚到第0张图片
//        page = self.adItems.count;
//    }else if (page == [self.collectionView numberOfItemsInSection:0] -1){//滚到最后一张图片
//        page = self.adItems.count -1;
//    }
//    [self.collectionView setContentOffset:CGPointMake(page * kScreenW, 0) animated:NO];
//     self.pageControl.currentPage = page % self.adItems.count;
//    //手指离开屏幕
//    [self addTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}


//代码滚动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)addTimer{
    if (self.timer) {
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)nextPage{
    //获得当前的页号
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
//    [self.collectionView setContentOffset:CGPointMake((page +1)*kScreenW, 0) animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(LotteryHallHeaderViewClick:)]) {
        [self.delegate LotteryHallHeaderViewClick:self.adItems[indexPath.item % self.adItems.count]];
    }
}


@end
