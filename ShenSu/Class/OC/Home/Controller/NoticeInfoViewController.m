//
//  NoticeInfoViewController.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "NoticeInfoViewController.h"
#import "NoticeViewCell.h"
#import "FXNoticeInfo.h"

@interface NoticeInfoViewController ()<NoticeViewCellDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSIndexPath *selectedIndexPath;
@end

@implementation NoticeInfoViewController

static NSString *const NoticeViewCellID = @"NoticeViewCell";


- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoticeViewCell" bundle:nil] forCellReuseIdentifier:NoticeViewCellID];
    self.title = @"通知中心";
   
    NSArray *keys = @[@"中奖通知",@"中奖动画",@"北京pk10",@"重庆时时彩",@"天津时时彩",@"新疆时时彩",@"上海时时乐",@"广东11选5",@"山东11选5",@"上海11选5",@"江西11选5",@"安徽快3",@"福彩3D",@"排列3"];
 
    for (int i = 0; i<14; i++) {
        FXNoticeInfo *info = [[FXNoticeInfo alloc]init];
        info.name = keys[i];
 //       info.status = [[kUserDefault valueForKey:keys[i]]boolValue];
        [self.datas addObject:info];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section ==1) {
        return 1;
    }
    return 12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"中奖通知";
    }else if (section == 1){
        return @"中奖动画";
    }
    return @"开奖通知";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return @"打开设置即可在开奖后获知中奖通知,为了避免频繁打扰,暂不支持快频彩";
    }else if (section == 1){
        return @"打开设置即可在中奖后获得中奖动画，及时了解中奖情况";
    }
    return @"打开设置即可在开奖后获知中奖通知,及时了解开奖号码";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NoticeViewCellID];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    if (indexPath.section == 0 ) {
        cell.info = self.datas[0];
    }else if (indexPath.section == 1){
        cell.info = self.datas[1];
    }else{
        cell.info = self.datas[2+indexPath.row];
    }
    
    return cell;
}

- (void)noticeViewCell:(UISwitch *)switchBtn andIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    
    if (!switchBtn.isOn) {
        UIAlertView *alerview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"关闭后你将无法及时知晓开奖通知，你真的要关闭吗?" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"取消", nil];
        [alerview show];
        return;
    }
    
    FXNoticeInfo *info = nil;
    if (self.selectedIndexPath.section == 2) {
        info = self.datas[self.selectedIndexPath.row + 2];
    }else {
        info = self.datas[self.selectedIndexPath.section];
    }
    
    info.status = switchBtn.isOn;
//    [kUserDefault setBool:info.status forKey:info.name];
//    [kUserDefault synchronize];
    [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.selectedIndexPath.section == 0) {
        FXNoticeInfo *info = self.datas[self.selectedIndexPath.row];
        info.status = (buttonIndex == 0) ? NO : YES;
//        [kUserDefault setBool:info.status forKey:info.name];
//        [kUserDefault synchronize];
    }else  if (self.selectedIndexPath.section == 2) {
        FXNoticeInfo *info = self.datas[2+ self.selectedIndexPath.row];
//        info.status = (buttonIndex == 0) ? NO : YES;
//        [kUserDefault setBool:info.status forKey:info.name];
//        [kUserDefault synchronize];
        
    }
    [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
