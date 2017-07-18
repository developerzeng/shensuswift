//
//  YHQAListController.m
//  github:  https://github.com/samuelandkevin
//
//  Created by samuelandkevin on 16/8/29.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import "YHTimeDetaTableView.h"
#import "CellForWorkGroup.h"
#import "CellForWorkGroupRepost.h"
#import "YHRefreshTableView.h"
#import "YHWorkGroup.h"
#import "YHUserInfoManager.h"
#import "YHUtils.h"
#import "YHSharePresentView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "JubaoTableViewController.h"

@interface YHTimeDetaTableView ()<UITableViewDelegate,UITableViewDataSource>{
    int _currentRequestPage; //当前请求页面
    BOOL _reCalculate;
}



@property (nonatomic,strong) YHRefreshTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *heightDict;
@end

@implementation YHTimeDetaTableView


- (void)viewDidLoad{
    [self initUI];
    [self addpinglun];
    [self requestDataLoadNew:YES];
    [self setNavRightButtonTitleWithTitle:@"举报" color:nil];
    __weak __typeof (self) weak = self;
    self.rightButtonClicked = ^(UIButton * btn){
        JubaoTableViewController * vc = [[JubaoTableViewController alloc] init];
        [weak.navigationController pushViewController:vc animated:true];
    };
    //设置UserId
    [YHUserInfoManager sharedInstance].userInfo.uid = @"1";
}

- (void)initUI{
    
    [self setNavTitleWithTitle:@"详情" color:nil];
    [self setDefaultNavBarWithForce:true];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    shadow.shadowOffset = CGSizeMake(0.5, 0.5);
    
    
    self.tableView = [[YHRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBCOLOR(244, 244, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView setEnableLoadNew:YES];
    [self.tableView setEnableLoadMore:YES];
    
    self.view.backgroundColor = RGBCOLOR(244, 244, 244);
    
    [self.tableView registerClass:[CellForWorkGroup class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    [self.tableView registerClass:[CellForWorkGroupRepost class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroupRepost class])];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
}


#pragma mark - Lazy Load
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)heightDict{
    if (!_heightDict) {
        _heightDict = [NSMutableDictionary new];
    }
    return _heightDict;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return  1;
    }
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        YHWorkGroup *model  = _dataModel;
        if (model.type == DynType_Forward) {
            //转发cell
            CellForWorkGroupRepost *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForWorkGroupRepost class])];
            if (!cell) {
                cell = [[CellForWorkGroupRepost alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellForWorkGroupRepost class])];
            }
            cell.indexPath = indexPath;
            cell.model = model;
            cell.delegate = self;
            return cell;
        }else{
            //原创cell
            CellForWorkGroup *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForWorkGroup class])];
            if (!cell) {
                cell = [[CellForWorkGroup alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
            }
            cell.indexPath = indexPath;
            cell.model = model;
            cell.delegate = self;
            return cell;
        }

    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        if(_dataArray.count > indexPath.row){
            if(_dataArray[indexPath.row][@"photo"] != nil){
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row][@"photo"][@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"common_avatar_120px"]];
            }else{
                cell.imageView.image = [UIImage imageNamed:@"common_avatar_120px"];
            }
            cell.imageView.layer.cornerRadius = cell.imageView.width/2;
            cell.imageView.layer.masksToBounds  = true;
            cell.textLabel.text = _dataArray[indexPath.row][@"nickname"];
            cell.detailTextLabel.text = _dataArray[indexPath.row][@"content"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        }
 
        
        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return  0;
    }else{
        return  30;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return @"全部评论";
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
            
            CGFloat height = 0.0;
            //原创cell
            Class currentClass  = [CellForWorkGroup class];
            YHWorkGroup *model  = _dataModel;
            
            //取缓存高度
            NSDictionary *dict =  self.heightDict[model.dynamicId];
            if (dict) {
                if (model.isOpening) {
                    height = [dict[@"open"] floatValue];
                }else{
                    height = [dict[@"normal"] floatValue];
                }
                if (height) {
                    return height;
                }
            }
            
            //转发cell
            if (model.type == DynType_Forward) {
                currentClass = [CellForWorkGroupRepost class];//第一版没有转发,因此这样稍该一下
                
                height = [CellForWorkGroupRepost hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    CellForWorkGroupRepost *cell = (CellForWorkGroupRepost *)sourceCell;
                    
                    cell.model = model;
                    
                }];
                
            }
            else{
                
                height = [CellForWorkGroup hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    CellForWorkGroup *cell = (CellForWorkGroup *)sourceCell;
                    
                    cell.model = model;
                    
                }];
            }
            
            //缓存高度
            if (model.dynamicId) {
                NSMutableDictionary *aDict = [NSMutableDictionary new];
                if (model.isOpening) {
                    [aDict setObject:@(height) forKey:@"open"];
                }else{
                    [aDict setObject:@(height) forKey:@"normal"];
                }
                [self.heightDict setObject:aDict forKey:model.dynamicId];
            }
            return height;
        


    }else{
    
        return  54;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - 网络请求
- (void)requestDataLoadNew:(BOOL)loadNew{
    YHRefreshType refreshType;
    if (loadNew) {
        _currentRequestPage = 0;
        refreshType = YHRefreshType_LoadNew;
        [self.tableView setNoMoreData:NO];
    }
    else{
        _currentRequestPage ++;
        refreshType = YHRefreshType_LoadMore;
    }
    
    [self.tableView loadBegin:refreshType];
    if (loadNew) {
        [self.dataArray removeAllObjects];
        [self.heightDict removeAllObjects];
    }
    
   NSDictionary * dic = @{
        @"mobiletype": @"iPhone9,1",
        @"mobilesysversion": @"10.3.1",
        @"pn": @"0",
        @"useragent": @"iPhone",
        @"app_channel": @"20004",
        @"sort": @"desc",
        @"mobilesysname": @"iOS",
        @"channel": @"20004",
        @"apple_hide": @"0",
        @"resolution": @"750*1334",
        @"version": @"3.6.7",
        @"userimei": @"bae56704 ba5bfc49 7c523eea b7c07061 b797910a 26eb4bce 64d671cc 66b65093",
        @"versioncode": @"364",
        @"openudid": @"8b7377ef817ad8b7639284a446483e4500a24310",
        @"platform": @"iphone",
        @"mbimei": @"E3F5536A141811DB40EFD6400F1D0A4E",
        @"pid": _dataModel.dynamicId,
        @"rn": @"10",
        @"isbreak": [NSString stringWithFormat:@"%d",_currentRequestPage],
        @"idfa": @"08F796DF-8DB8-4518-B3F6-B4C08884E046"
        };

    
    [[ObjectNet default] requesMethodtWithUrlWithUrl:@"http://ews.500.com/sns/app/commentlist?"  parameters:dic  completionHandler:^( NetworkStatus status , id data) {
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:data];
        if (status == NetworkStatusSuccess && [dic[@"status"] intValue] == 100){
            [dic[@"data"][@"commentlist"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataArray addObject:obj];
            }];
            [self.tableView loadFinish:refreshType];
            [self.tableView reloadData];
        }
    }];
    

}

-(void)addpinglun{
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,self.view.height - 44, self.view.width, 44);
    btn.backgroundColor = [UIColor orangeRedColor];
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(useraddpinglun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_offset(44);
    }];
}
-(void)useraddpinglun{
  __block NSDictionary * dic = [[NSDictionary alloc] init];

  __block  NSString * str = @"";
    __block   UITextField * textfiled ;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"评论" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textfiled = textField;
     
    }];
    UIAlertAction * defa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        str = textfiled.text;
        dic = @{
                @"username": @"AK**",
                @"liked": @"0",
                @"uid": @"18632276",
                @"op_status": @(1),
                @"pid": @219761,
                @"floor": @(5),
                @"unqid": @"519887de8d2acbcce999d97c2b682fb9",
                @"r_content": @"",
                @"content": str,
                @"reported": @"0",
                @"r_username": @"",
                @"likes": @"0",
                @"photo": @{},
                @"date": @"2017-07-12 13:34:14",
                @"_id": @(639435),
                @"nickname": @"可爱狼"
                };
        
        if (str.length == 0){
            [self showMessageWithMessage:@"请输入您要评论的文字"];
        }else{
            [self showLoadingView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hideLoadingView];
                [self showMessageWithMessage:@"评论成功"];
//                [self.dataArray addObject:dic];
                [self.dataArray insertObject:dic atIndex:0];
                [self.tableView reloadData];
            });
        }
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:defa];
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];

}

#pragma mark - YHRefreshTableViewDelegate
- (void)refreshTableViewLoadNew:(YHRefreshTableView*)view{
    [self requestDataLoadNew:YES];
}

- (void)refreshTableViewLoadmore:(YHRefreshTableView*)view{
    [self requestDataLoadNew:NO];
}



- (void)onMoreInCell:(CellForWorkGroup *)cell{
    DDLog(@"查看详情");
    if (cell.indexPath.row < [self.dataArray count]) {
        YHWorkGroup *model = self.dataArray[cell.indexPath.row];
        model.isOpening = !model.isOpening;
        [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}




#pragma mark - UIScrollViewDelegate


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
