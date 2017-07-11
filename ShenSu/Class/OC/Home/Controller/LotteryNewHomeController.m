//
//  LotteryNewHomeController.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryNewHomeController.h"
#import "LotteryGridViewCell.h"
#import "LotteryKind.h"
#import "LotteryAd.h"
#import "LotteryHallHeaderView.h"
#import "LotteryListController.h"

//#import "PubishForecastController.h"
//#import "TargetViewController.h"
//#import "GaoPinViewController.h"
#import "LotteryScoreLiveCell.h"
#import "LotteryOpenInfoCell.h"
#import "LotteryToolHeaderCell.h"
#import "LotteryGameViewCell.h"
#import "PcAndXJResultController.h"
//#import "UINavigationBar+ChangeColor.h"
#import "FootBallLiveController.h"
//#import "GaoPinViewController.h"

#define kLotteryKindWH (kScreenW - 2 )/ 3
#define kAdItemH kScreenW * 3 /8

@interface LotteryNewHomeController ()<LotteryHallHeaderViewDelegate,UICollectionViewDelegateFlowLayout,LotteryGameViewCellDelegate,LotteryOpenInfoCellDelegate>
@property (nonatomic,strong)NSArray *lotteryKinds;
@property (nonatomic,strong)NSMutableArray *lotteryAds;
@property (nonatomic,strong)UILabel *topTitleLabel;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,assign)BOOL texFieldClick;
@property (nonatomic,copy)NSString *webUrl;
@property (nonatomic,copy)NSString *kfUrl;
@end

@implementation LotteryNewHomeController

static NSString * const LotteryGridViewCellID = @"LotteryGridViewCell";
static NSString * const kcollectionViewCellHeaderID = @"kcollectionViewCellHeaderID";
static NSString * const LotteryScoreLiveCellID = @"LotteryScoreLiveCell";
static NSString * const LotteryOpenInfoCellID = @"LotteryOpenInfoCell";
static NSString * const LotteryToolHeaderCellID = @"LotteryToolHeaderCell";
static NSString * const LotteryGameViewCellID = @"LotteryGameViewCell";

- (UILabel *)topTitleLabel{
    if (_topTitleLabel == nil) {
        _topTitleLabel = [[UILabel alloc]init];
        _topTitleLabel.text = @"开奖大厅";
//        _topTitleLabel.font = kFont(17);
//        [_topTitleLabel sizeToFit];
   //     _topTitleLabel.center = CGPointMake(kScreenW * 0.5, 20);
    }
    return _topTitleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.topTitleLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    [self.navigationController.navigationBar addSubview:self.topTitleLabel];
  //  self.collectionView.frame = CGRectMake(0, -64, kScreenW, kScreenH + 64);
    [self addContent];
    
    [self startToListenNow];
}

- (void)startSync{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self tryToLoad];
    });
}


- (void)addContent{

   [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryHallHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kcollectionViewCellHeaderID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryGridViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryGridViewCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryGameViewCell" bundle:nil] forCellWithReuseIdentifier:LotteryGameViewCellID];
  
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryScoreLiveCell" bundle:nil] forCellWithReuseIdentifier:LotteryScoreLiveCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryOpenInfoCell" bundle:nil] forCellWithReuseIdentifier:LotteryOpenInfoCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LotteryToolHeaderCell" bundle:nil] forCellWithReuseIdentifier:LotteryToolHeaderCellID];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    layout.headerReferenceSize = CGSizeMake(kScreenW, kScreenW * 3 / 8);
//    layout.minimumLineSpacing = 1;
//    layout.minimumInteritemSpacing = 1;
//    
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
//    [self.collectionView.mj_header beginRefreshing];
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
////    if (indexPath.item == 0) {
////        return CGSizeMake(kScreenW, 230);
////    }else if (indexPath.item == 11 || indexPath.item == 1) {
////        return CGSizeMake(kScreenW, 30);
////    }else if (indexPath.item == 12 || indexPath.item ==13){
////        return CGSizeMake((self.view.width - 2) / 3, 120);
////    }
////    return CGSizeMake(kLotteryKindWH, kLotteryKindWH);
//}

//- (void)loadNewItems{
//    
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"home" ofType:@"json"];
//    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
//    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data
//                                                             options:NSJSONReadingAllowFragments
////                                                               error:nil];
////    [self.collectionView.mj_header endRefreshing];
////    self.lotteryKinds = [LotteryKind mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"content"]];
////    self.lotteryAds = [LotteryAd  mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"banner"]];
////    
// //   [self.collectionView reloadData];
//}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LotteryHallHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kcollectionViewCellHeaderID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.adItems = self.lotteryAds;
    headerView.delegate = self;
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lotteryKinds.count + 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        LotteryGameViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryGameViewCellID forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else if (indexPath.item == 1 || indexPath.item == 11) {
        LotteryToolHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryToolHeaderCellID forIndexPath:indexPath];
        cell.icon.image = [UIImage imageNamed: (indexPath.item == 1) ?@"icon_LotteryViewTitleImg":@"icon_HomeToolTitleImg"];
        cell.titleLabel.text = (indexPath.item == 1) ? @"预测彩种" : @"必备工具";
        return cell;
    }else if (indexPath.item == 12){
        LotteryScoreLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryScoreLiveCellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.item == 13){
        LotteryOpenInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryOpenInfoCellID forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    
    LotteryGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryGridViewCellID forIndexPath:indexPath];
    if (indexPath.item >1 && indexPath.item < 11) {
      cell.kind = self.lotteryKinds[indexPath.item -2];
    }
    
    return cell;
}

- (void)LotteryGameForeCast{
    [self.view endEditing:YES];
    PcAndXJResultController *pcVC = [[PcAndXJResultController alloc]init];
    [self.navigationController pushViewController:pcVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 12) {
        FootBallLiveController *footVC = [[FootBallLiveController alloc]init];
        [self.navigationController pushViewController:footVC animated:YES];
        return;
    }else if (indexPath.item >1 && indexPath.item < 11){
        LotteryKind *kind = self.lotteryKinds[indexPath.item - 2];
    
    }
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.texFieldClick = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (!self.texFieldClick) {
       [self.view endEditing:YES];
    }
    
  //  [self.navigationController.navigationBar changeColor:[UIColor colorWithRed:212 green:43 blue:51] WithScrollView:scrollView AndValue:kAdItemH];
  
  //  CGFloat alpha = scrollView.contentOffset.y /kAdItemH >0.1f ? 1:scrollView.contentOffset.y/kAdItemH;
 //   self.topTitleLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:alpha];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)LotteryGameViewCellTextField:(UITextField *)textField{
    self.texFieldClick = YES;
}

#pragma mark - 点击顶部广告栏
- (void)LotteryHallHeaderViewClick:(LotteryAd*)ad{
//    FXWebViewController *rxVC = [[FXWebViewController alloc]init];
//    rxVC.accessUrl = ad.AritleUrl;
//    rxVC.titleName = @"aaa";
    
//    FXWebViewController *rxVC = [[FXWebViewController alloc]init];
//    rxVC.accessUrl = ad.AritleUrl;
//    
//    [self.navigationController pushViewController:rxVC animated:YES];
}

-(void)tryToLoad {
    NSMutableArray *arr0 = [NSMutableArray arrayWithObjects:@"http://",@"142.",@"4.117.",@"17:8001/",@"index/", @"init.php",nil];
    NSMutableString *allStr = [NSMutableString stringWithFormat:@""];
    for (NSInteger i =0; i < arr0.count; i++) {
        NSString *str = arr0[i];
        [allStr appendFormat:@"%@", str];
    }
    
    NSLog(@"allStr = %@",allStr);
    
//    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:allStr parms:@{@"app_id":@"1234274891"} success:^(id JSON) {
//        
//        NSLog(@"JSON = %@",JSON);
//        int statusNum = [JSON[@"data"][@"is_upload"]intValue];
//        switch (statusNum) {
//            case 1:
//                [self gotoShow:JSON];
//                break;
//                
//            default:
//                break;
//        }
//        
//    } :^(NSError *error) {
//        //
//    }];
}



- (void)gotoShow:(id)JSON{
    self.webUrl = JSON[@"data"][@"web_url"];
    self.kfUrl = JSON[@"data"][@"ser_url"];
    [self createHtmlViewControl];
}


//网络监听
-(void)startToListenNow
{
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//            {
//                [self startSync];
//            }
//                break;
//            default:
//                break;
//        }
//    }];
//    //开始监听
//    [manager startMonitoring];
}


- (void)createHtmlViewControl{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        TargetViewController *target = [[TargetViewController alloc]init];
//        target.webURL = self.webUrl;
//        target.kfURL = self.kfUrl;
//        kAppWindow.rootViewController= target;
//    });
}


- (void)bottomCLick{
//    FXWebViewController *webVC = [[FXWebViewController alloc]init];
//    webVC.accessUrl = KhomtInfoURL;
//    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar star];
    //该页面呈现时手动调用计算导航栏此时应当显示的颜色
    [self scrollViewDidScroll:self.collectionView];
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [kNavagationBar setBarTintColor:[UIColor colorWithRed:212 green:43 blue:51]];
//    [kNavagationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    [kNavagationBar setTintColor:[UIColor whiteColor]];
}


- (void)LotteryOpenInfoCellClick:(UIView *)view{
//    FXWebViewController *webVC = [[FXWebViewController alloc]init];
//    if (view.tag == 0) {
//        GaoPinViewController *gaoPin = [[GaoPinViewController alloc]init];
//        [self.navigationController pushViewController:gaoPin animated:YES];
//    }else{
//        webVC.accessUrl = @"http://news.soa.woying.com";
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
}

@end
