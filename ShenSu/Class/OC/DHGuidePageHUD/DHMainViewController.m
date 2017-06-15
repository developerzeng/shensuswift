//
//  DHMainViewController.m
//  DHGuidePageHUDExample
//
//  Created by Apple on 16/7/14.
//  Copyright © 2016年 dingding3w. All rights reserved.
//

#import "DHMainViewController.h"
#import "DHGuidePageHUD.h"

@interface DHMainViewController ()

@end

@implementation DHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the viewO(∩_∩)O.
    // 设置APP引导页
    self.view.backgroundColor = [UIColor whiteColor];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
        [self setStaticGuidePage];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"引导页1.jpg",@"引导页2.jpg",@"引导页3.jpg",@"引导页4.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.isremoveFromWindows = ^(){
        if (self.isremoveFromWindows){
            self.isremoveFromWindows();
        }
    };
    guidePage.slideInto = YES;
    [self.view addSubview:guidePage];
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
