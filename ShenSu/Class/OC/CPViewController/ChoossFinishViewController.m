//
//  ChoossFinishViewController.m
//  +
//
//  Created by shensu on 17/4/24.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ChoossFinishViewController.h"
#import "CpMapViewController.h"
#import "Shensu-swift.h"
@interface ChoossFinishViewController ()

@end

@implementation ChoossFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavLeftButtonWithImage:[UIImage imageNamed:@"Go_Back"] highlight:[UIImage imageNamed:@"Go_Back"]];
    __weak __typeof (self) weak = self;
    [self setLeftButtonClicked:^(id btn) {
        [weak.navigationController popToViewControllerWithViewClass:[PfBuyLottreyViewController class]];
    }];
    [self setNavTitleWithTitle:@"保存成功" color:nil];

    [_goBtn setTitle:@"返回" forState:UIControlStateNormal];
    _goBtn.backgroundColor = [UIColor orangeRedColor];
    
}
-(void)rightClick{

}
- (IBAction)goBtnClick:(id)sender {

    [self.navigationController popToViewControllerWithViewClass:[PfBuyLottreyViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
