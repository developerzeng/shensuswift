//
//  FootBallLiveController.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/15.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FootBallLiveController.h"
#import "FootBallLivewCell.h"
#import "FXFootBallLive.h"
//#import "FXWebViewController.h"

@interface FootBallLiveController ()<UITableViewDelegate,FootBallLivewCellDelegate>
@property (weak, nonatomic) IBOutlet UIButton *attentBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,weak)UIButton *selectedBtn;
@property (nonatomic,copy)NSString *selectedLiveType;
@property (nonatomic,copy)NSString *statType;
@property (nonatomic,strong)NSMutableArray *footBallAttentionArr;
@property (nonatomic,strong)NSMutableArray *basketBallAttentionArr;
@end

@implementation FootBallLiveController
static NSString * const FootBallLivewCellID = @"FootBallLivewCell";

- (NSMutableArray *)footBallAttentionArr{
    if (_footBallAttentionArr == nil) {
        _footBallAttentionArr = [NSMutableArray array];
    }
    return _footBallAttentionArr;
}

- (NSMutableArray *)basketBallAttentionArr{
    if (_basketBallAttentionArr ==nil) {
        _basketBallAttentionArr = [NSMutableArray array];
    }
    return _basketBallAttentionArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"FootBallLivewCell" bundle:nil] forCellReuseIdentifier:FootBallLivewCellID];
    self.tableView.rowHeight = 80;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:@[@"足球",@"篮球"]];
    
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(sementedClick:) forControlEvents:UIControlEventValueChanged];
    control.frame = CGRectMake(0, 0, 100, 30);
//    control.center = CGPointMake(kScreenW * 0.5, 20);
    [self.navigationController.navigationBar addSubview:control];
    self.selectedLiveType = @"1";
    self.statType = @"1";
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView.mj_header beginRefreshing];
}


- (void)loadNewItems{
    if ([self.statType intValue] == 3) {
//        [self.tableView.mj_header endRefreshing];
        return;
    }
//     NSString *dateStr = [NSDate getFormatDateStringWithDate:[NSDate date] withFormatStyle:@"yyyy-MM-dd"];
//    
//    NSDictionary *dict = @{@"lType":self.selectedLiveType,@"statType":self.statType,@"issue":[self.statType isEqualToString:@"2"]? dateStr : @""};
//    
    NSString *url = [self.selectedLiveType isEqualToString:@"2"]?@"http://api.datacenter.woying.com/Basketball/score" : @"http://api.datacenter.woying.com/soccer/score";
    
    
 //   NSLog(@"dict = %@",dict);
    
//    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:url parms:dict success:^(id JSON) {
//        [self.tableView.mj_header endRefreshing];
//        
//        self.dataArr = [FXFootBallLive mj_objectArrayWithKeyValuesArray:JSON[@"dataObj"][@"List"]];
//        [self.tableView reloadData];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.tableView.separatorInset = UIEdgeInsetsZero;
//        
//    } :^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//    }];
}


- (void)sementedClick:(UISegmentedControl *)control{
    //NSLog(@"%d",control.selectedSegmentIndex);
    self.selectedLiveType = [NSString stringWithFormat:@"%ld",control.selectedSegmentIndex+1];

    if ([self.statType intValue] == 3) {
        if ([self.selectedLiveType intValue] == 1) {
            self.dataArr = [NSMutableArray arrayWithArray:self.footBallAttentionArr];
        }else{
            self.dataArr = [NSMutableArray arrayWithArray:self.basketBallAttentionArr];
        }
        
        [self.attentBtn setTitle:[NSString stringWithFormat:@"%ld",self.dataArr.count] forState:UIControlStateNormal];
        self.attentBtn.hidden = !self.dataArr.count;
        [self.tableView reloadData];
    }else{
        [self loadNewItems];
    }
    
}

- (IBAction)topBtnClick:(UIButton *)sender {
    self.statType = [NSString stringWithFormat:@"%ld",sender.tag];
    
    [UIView animateWithDuration:0.5 animations:^{
  //      self.sliderView.centerX = sender.centerX;
        if (sender.tag == 3) {
            if ([self.selectedLiveType intValue] == 1) {
               self.dataArr = [NSMutableArray arrayWithArray:self.footBallAttentionArr];
            }else if ([self.selectedLiveType intValue]==2){
                 self.dataArr = [NSMutableArray arrayWithArray:self.basketBallAttentionArr];
            }
            
            
            [self.tableView reloadData];
        }else{
           [self loadNewItems];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FootBallLivewCell *cell = [tableView dequeueReusableCellWithIdentifier:FootBallLivewCellID forIndexPath:indexPath];
    cell.live = self.dataArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)FootBallLivewCellCollection:(FootBallLivewCell *)cell andSelected:(BOOL)selected{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FXFootBallLive *live = self.dataArr[indexPath.row];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    if ([self.selectedLiveType isEqualToString:@"1"]) {
        if (selected) {
            [self.footBallAttentionArr addObject:live];
        }else{
            [self.footBallAttentionArr removeObject:live];
        }
        [self.attentBtn setTitle:[NSString stringWithFormat:@"%ld",self.footBallAttentionArr.count] forState:UIControlStateNormal];
        self.attentBtn.hidden = !self.footBallAttentionArr.count;
        if ([self.statType intValue] == 3) {
            self.dataArr = [NSMutableArray arrayWithArray:self.footBallAttentionArr];
            [self.tableView reloadData];
        }
       
    }else if ([self.selectedLiveType isEqualToString:@"2"]){
        if (selected) {
            [self.basketBallAttentionArr addObject:live];
        }else{
            [self.basketBallAttentionArr removeObject:live];
        }
        [self.attentBtn setTitle:[NSString stringWithFormat:@"%ld",self.basketBallAttentionArr.count] forState:UIControlStateNormal];
        self.attentBtn.hidden = !self.basketBallAttentionArr.count;
        if ([self.statType intValue] == 3) {
            self.dataArr = [NSMutableArray arrayWithArray:self.basketBallAttentionArr];
            [self.tableView reloadData];
        }
        
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FXFootBallLive *live = self.dataArr[indexPath.row];
//    FXWebViewController *webVC = [[FXWebViewController alloc]init];
//    webVC.accessUrl = live.Xi;
//    webVC.titleName = @"赛事分析";
//    [self.navigationController pushViewController:webVC animated:YES];
}


@end
