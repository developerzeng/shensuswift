//
//  PcAndXJResultController.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/27.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "PcAndXJResultController.h"

@interface PcAndXJResultController ()

@end

@implementation PcAndXJResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选号成功";
    
  //  self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithName:@"" target:nil andSEL:nil];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
