//
//  LQKGeneralWebViewController.m
//  Basketball
//
//  Created by 牛胖胖 on 2017/3/14.
//  Copyright © 2017年 lanqiuke. All rights reserved.
//

#import "LQKGeneralWebViewController.h"
#import "Shensu-swift.h"
@interface LQKGeneralWebViewController ()

@end

@implementation LQKGeneralWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [defaults valueForKey:@"pushMessage"];
    if (dic){
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"消息" message:dic[@"alert"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:sure];
            [self presentViewController:alert animated:true completion:nil];
            
            [self showMessageWithMessage:dic[@"alert"]];
        });
        
        [defaults removeObjectForKey:@"pushMessage"];
    }
    
    
  //  [self setNavBar];
    if (self.idleTimerDisabled) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    }
    self.navigationButtonsHidden = YES;
    self.showLoadingBar = YES;
}

- (void)setWebUrl:(NSURL *)webUrl
{
    self.url = webUrl;
}

// 设置返回按钮
-(void)setNavBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 0, 44, 44)];
    [left setImage:[UIImage imageNamed:@"image/top_back_icon"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    left.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:left];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -20;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftButton];
    }else{
        self.navigationController.topViewController.navigationItem.leftBarButtonItem = leftButton;
    }
}

- (void)close {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait ;
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL shouldStart = YES;
    shouldStart = [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    NSString* originalString = [[request URL] absoluteString];
    NSString *requestString = [originalString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    if (!self.jsonManager) {
    //        _jsonManager = [ZTHIOSJSCommunicationUIJumpManager managerWithURL:requestString superViewController:self];
    //    }else{
    //        [self.jsonManager parseURL:requestString];
    //    }
    //    return (shouldStart && [self.jsonManager shouldStartLoad]);
    return YES;
}



@end
