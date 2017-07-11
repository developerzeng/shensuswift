//
//  HomeViewController.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryHomeController.h"
#import "LotteryHomeViewCell.h"
#import "LotteryListController.h"

@interface LotteryHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate,LotteryHomeViewCellDelegate>
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic,strong)UISegmentedControl *control;
@property (nonatomic,strong)NSArray *requestKeys;
@end

@implementation LotteryHomeController

static NSString *const LotteryHomeViewCellID = @"LotteryHomeViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.requestKeys = @[@"quanguo",@"difang",@"gaopin"];
   
    [self addCollectionView];
    
 //   self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithName:@"分享" target:self andSEL:@selector(share)];
    
    
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:@[@"全国",@"地方",@"高频"]];
    self.control = control;
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(sementedClick:) forControlEvents:UIControlEventValueChanged];
    control.frame = CGRectMake(0, 0, 150, 30);
    self.navigationItem.titleView = control;
}



- (void)sementedClick:(UISegmentedControl *)control{
   
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:control.selectedSegmentIndex inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


- (void)addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout = layout;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
 //   collectionView.backgroundColor = kBackGroundColor;
    self.collectionView = collectionView;

    [collectionView registerNib:[UINib nibWithNibName:@"LotteryHomeViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryHomeViewCellID];
    
    [self.view addSubview:collectionView];
}


- (void)viewDidLayoutSubviews{
    self.layout.itemSize = self.view.bounds.size;
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.requestKeys.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LotteryHomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryHomeViewCellID forIndexPath:indexPath];
    cell.requestKey = self.requestKeys [indexPath.item];
    cell.delegate = self;
    return cell;
}


- (void)lotteryHomeCellClick:(Lottery *)lottery{
    LotteryListController *lotteryListVc = [[LotteryListController alloc]init];
    lotteryListVc.lottery = lottery;
    [self.navigationController pushViewController:lotteryListVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  //  int currentIndex = scrollView.contentOffset.x / kScreenW ;
    
  //  self.control.selectedSegmentIndex = currentIndex;
}


@end
