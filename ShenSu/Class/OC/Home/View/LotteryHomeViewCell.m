//
//  HomeCollectionViewCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/26.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryHomeViewCell.h"
#import "LotteryViewCell.h"
#import "Lottery.h"
#import "LotteryDiFang.h"
#import "LotteryHeaderView.h"
#import "LotteryListController.h"

@interface LotteryHomeViewCell()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,strong)NSArray<LotteryDiFang *> *DFArray;
@end
static NSString *const LotteryViewCellID = @"LotteryViewCell";
static NSString *const LotteryHeaderViewID = @"LotteryHeaderView";
@implementation LotteryHomeViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryViewCell" bundle:nil] forCellReuseIdentifier:LotteryViewCellID];
  //  self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:LotteryHeaderViewID];
}



- (void)loadNewItems{
    
    self.requestKey = @"quanguo";
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"kaijiang.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
  
//        [self.tableView.mj_header endRefreshing];
//        
//        if ([self.requestKey isEqualToString:@"quanguo"]) {
//            self.datas = [Lottery mj_objectArrayWithKeyValuesArray:JSON[@"data"][self.requestKey]];
//        }else{
//            self.DFArray = [LotteryDiFang mj_objectArrayWithKeyValuesArray:JSON[@"data"][self.requestKey]];
//        }
    
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.tableView reloadData];
    
}



- (void)setRequestKey:(NSString *)requestKey{
    _requestKey = requestKey;
    if (self.datas.count || self.DFArray.count) {
        
    }else{
    //  [self.tableView.mj_header beginRefreshing];
    }
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.requestKey isEqualToString:@"quanguo"]? self.datas.count : [[self.DFArray[section]data]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LotteryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryViewCellID forIndexPath:indexPath];
    
    cell.lottery = [self.requestKey isEqualToString:@"quanguo"]? self.datas[indexPath.row]: [self.DFArray[indexPath.section]data][indexPath.row];
    
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.requestKey isEqualToString:@"quanguo"]?1 : self.DFArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.requestKey isEqualToString:@"quanguo"]? 0 :30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LotteryHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LotteryHeaderViewID];
    view.headerName = [self.DFArray[section]province];
    return [self.requestKey isEqualToString:@"quanguo"]? nil : view;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    Lottery *lottery = [self.requestKey isEqualToString:@"quanguo"] ? self.datas[indexPath.row] : [self.DFArray[indexPath.section]data][indexPath.row];
    if ([self.delegate respondsToSelector:@selector(lotteryHomeCellClick:)]) {
        [self.delegate lotteryHomeCellClick:lottery];
    }
}


@end
