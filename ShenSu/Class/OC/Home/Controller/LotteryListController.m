//
//  LotteryListController.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryListController.h"
#import "LotteryViewCell.h"
#import "Lottery.h"
#import "LotteryResultController.h"
//#import "LoginViewController.h"
//#import "FXNavigationController.h"

@interface LotteryListController ()
@property (nonatomic,strong)NSMutableArray<Lottery *> *lotteryListArray;
@property (nonatomic,copy)NSString *requestURL;
@end

static NSString *const LotteryListViewCellID = @"LotteryListViewCellID";

@implementation LotteryListController

- (NSMutableArray<Lottery *> *)lotteryListArray{
    if (_lotteryListArray == nil) {
        _lotteryListArray = [NSMutableArray array];
    }
    return _lotteryListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@开奖结果",self.kind.lottery_name];
    self.requestURL = @"http://t.apiplus.net/ssq.json";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"collection_nor"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"collection_sel"] forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryViewCell" bundle:nil] forCellReuseIdentifier:LotteryListViewCellID];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
//    [self.tableView.mj_header beginRefreshing];
}

- (void)collection:(UIButton *)button{
//    if (kAccount == nil) {
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        loginVC.block = ^{
//            [self gotoCollection:button];
//        };
//        FXNavigationController *nav = [[FXNavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else{
//        [self gotoCollection:button];
//    }
}


- (void)gotoCollection:(UIButton *)button{
    button.selected = !button.selected;
//    if (button.selected) {
//        [MBProgressHUD showSuccess:@"收藏成功"];
//    }else{
//        [MBProgressHUD showSuccess:@"取消收藏"];
//    }
}

- (void)loadNewItems{
//    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:self.requestURL parms:nil success:^(id JSON) {
//        [self.tableView.mj_header endRefreshing];
//        self.lotteryListArray = [Lottery mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
//        [self.tableView reloadData];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    } :^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lotteryListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LotteryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryListViewCellID forIndexPath:indexPath];
    
    cell.lottery = self.lotteryListArray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryResultController *lotteryListVc = [[LotteryResultController alloc]init];
    lotteryListVc.lottery = self.lotteryListArray[indexPath.row];
    lotteryListVc.kind = self.kind;
    [self.navigationController pushViewController:lotteryListVc animated:YES];
}




@end
