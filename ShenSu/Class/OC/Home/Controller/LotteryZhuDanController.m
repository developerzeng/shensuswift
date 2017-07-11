//
//  LotteryZhuDanController.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/2.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryZhuDanController.h"
#import "LotteryZhuDanCell.h"
#import "Lottery.h"
#import "PcAndXJResultController.h"
//#import "PubishForecastController.h"
//#import "FXNavigationController.h"
//#import "Board.h"

@interface LotteryZhuDanController ()<LotteryZhuDanCellDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *zhuiTF;
@property (weak, nonatomic) IBOutlet UITextField *touTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSIndexPath *selectedIndexPath;
@property (nonatomic,strong)NSMutableArray *pours;//注数
@end
static NSString *const LotteryZhuDanCellID = @"LotteryZhuDanCell";
@implementation LotteryZhuDanController


- (NSMutableArray *)pours{
    if (_pours== nil) {
        _pours = [NSMutableArray array];
    }
    return _pours;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"注单";
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self.pours addObject:self.collectionBoards];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryZhuDanCell" bundle:nil] forCellReuseIdentifier:LotteryZhuDanCellID];
    
  //  self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithName:@"确定" target:self andSEL:@selector(sureAction)];
    [self.tableView reloadData];
}



- (void)sureAction{
    if (self.pours.count) {
        PcAndXJResultController *pcVc = [[PcAndXJResultController alloc]init];
        pcVc.isPresented = YES;
        [self.navigationController pushViewController:pcVc animated:YES];
    }else{
  //      [MBProgressHUD showError:@"你还没有选择下注"];
    }
}

- (IBAction)topTitleAction:(UIButton *)sender {
//    if (sender.tag == 0) {
//        PubishForecastController *pcVc = [[PubishForecastController alloc]init];
//        pcVc.block = ^(NSArray *boards){
//            [self.pours addObject:boards];
//            [self.tableView reloadData];
//        };
//        
//        pcVc.isPresented = YES;
//        pcVc.publishType = self.publishType;
//        FXNavigationController *nav = [[FXNavigationController alloc]initWithRootViewController:pcVc];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else{
//        //机选
//        if (self.publishType == 0 || self.publishType == 1 || self.publishType == 7) {
//            int index = 0;
//            NSMutableArray *arcNum = [NSMutableArray array];
//            if (self.publishType == 1) {
//                index = 5;
//            }else if (self.publishType == 7){
//                index = 7;
//            }else{
//                index = 6;
//            }
//            
//            NSMutableArray *boards = [NSMutableArray array];
//            arcNum = [FXTools GetRandomWithStartIndex:1 andEndIndex:30 youWantNums:index weishu:2];
//            for (int i = 0; i<arcNum.count; i++) {
//                Board *board = [self makeBoard:arcNum[i] andColor:@"red"];
//                [boards addObject:board];
//            }
//            NSMutableArray *lanNumbers = [NSMutableArray array];
//            if (self.publishType == 1) {
//                lanNumbers = [FXTools GetRandomWithStartIndex:1 andEndIndex:12 youWantNums:2 weishu:2];
//            }else{
//                lanNumbers = [FXTools GetRandomWithStartIndex:1 andEndIndex:16 youWantNums:1 weishu:2];
//            }
//            
//            for (int i = 0; i<lanNumbers.count; i++) {
//                Board *board = [self makeBoard:arcNum[i] andColor:@"blue"];
//                [boards addObject:board];
//            }
//            [self.pours addObject:boards];
//            [self.tableView reloadData];
//            
//        }else if (self.publishType == 8 || self.publishType == 6){
//            NSMutableArray *boards = [NSMutableArray array];
//            NSMutableArray *arcNum = [FXTools GetRandomWithStartIndex:1 andEndIndex:11 youWantNums:5 weishu:1];
//            for (int i = 0; i<arcNum.count; i++) {
//                Board *board = [self makeBoard:arcNum[i] andColor:@"red"];
//                [boards addObject:board];
//            }
//            [self.pours addObject:boards];
//            [self.tableView reloadData];
//        }else if (self.publishType == 4){
//            NSMutableArray *boards = [NSMutableArray array];
//            NSMutableArray *arcNum = [FXTools GetRandomWithStartIndex:1 andEndIndex:9 youWantNums:7 weishu:1];
//            for (int i = 0; i<arcNum.count; i++) {
//                Board *board = [self makeBoard:arcNum[i] andColor:@"red"];
//                [boards addObject:board];
//            }
//            [self.pours addObject:boards];
//            [self.tableView reloadData];
//        }else{
//            if (self.publishType == 2 || self.publishType == 3 || self.publishType == 5) {
//                NSMutableArray *boards = [NSMutableArray array];
//                NSMutableArray *arcNum = [FXTools GetRandomWithStartIndex:1 andEndIndex:9 youWantNums:3 weishu:1];
//                for (int i = 0; i<arcNum.count; i++) {
//                    Board *board = [self makeBoard:arcNum[i] andColor:@"red"];
//                    [boards addObject:board];
//                }
//                [self.pours addObject:boards];
//                [self.tableView reloadData];
//            }
//        }
//    }
}

//
//- (Board *)makeBoard:(NSString *)number andColor:(NSString *)color{
//    Board *b = [[Board alloc]init];
//    b.number = number;
//    b.color = color;
//    return b;
//}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pours.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LotteryZhuDanCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryZhuDanCellID forIndexPath:indexPath];
    cell.boards = self.pours[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)LotteryZhuDanCellDeletedCell:(LotteryZhuDanCell*)cell{
    
    self.selectedIndexPath = [self.tableView indexPathForCell:cell];
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除这注号码?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSArray *boards = self.pours[self.selectedIndexPath.row];
        [self.pours removeObject:boards];
        [self.tableView reloadData];
    }
}

- (IBAction)zhuijianAction:(id)sender {
    int zhui = [self.zhuiTF.text intValue];
    zhui --;
    if (zhui == 0) {
        self.zhuiTF.text = @"1";
    }else{
        self.zhuiTF.text = [NSString stringWithFormat:@"%d",zhui];
    }
}
- (IBAction)zhuijiaAction:(id)sender {
    int zhui = [self.zhuiTF.text intValue];
    zhui ++;
    self.zhuiTF.text = [NSString stringWithFormat:@"%d",zhui];
}

- (IBAction)toujianAction:(id)sender {
    int tou = [self.touTF.text intValue];
    tou --;
    if (tou == 0) {
        self.touTF.text = @"1";
    }else{
        self.touTF.text = [NSString stringWithFormat:@"%d",tou];
    }
}
- (IBAction)toujiaAciton:(id)sender {
    int tou = [self.touTF.text intValue];
    tou ++;
    self.touTF.text = [NSString stringWithFormat:@"%d",tou];
}

@end
