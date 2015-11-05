//
//  DemoViewController.m
//  NetworkEye
//
//  Created by coderyi on 15/11/5.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "DemoViewController.h"
#import "NEHTTPEye.h"
#import "NEHTTPEyeViewController.h"
@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testRequest];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"NetworkEye";
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, [[UIScreen mainScreen] bounds].size.width-20, 45)];
    [self.view addSubview:label];
    label.textColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    label.font=[UIFont systemFontOfSize:12];
    label.numberOfLines=0;
    label.text=@"监控App内所有HTTP请求并显示请求相关的所有信息，方便App开发的网络调试。";
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
    bt.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-160)/2, 90, 160, 50);
    [bt setTitle:@"Go NetworkEye" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    bt.layer.borderColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f].CGColor;
    bt.layer.borderWidth=0.4;
    
    UIButton *bt1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bt1];
    [bt1 addTarget:self action:@selector(bt1Action) forControlEvents:UIControlEventTouchUpInside];
    bt1.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-190)/2, 170, 190, 40);
    [bt1 setTitle:@"Click to right request" forState:UIControlStateNormal];
    [bt1 setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    bt1.layer.borderColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f].CGColor;
    bt1.layer.borderWidth=0.4;
    
    UIButton *bt2=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bt2];
    [bt2 addTarget:self action:@selector(bt2Action) forControlEvents:UIControlEventTouchUpInside];
    bt2.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-190)/2, 225, 190, 40);
    [bt2 setTitle:@"Click to error request" forState:UIControlStateNormal];
    [bt2 setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    bt2.layer.borderColor=[UIColor colorWithRed:0.9 green:0.31 blue:0.28 alpha:1].CGColor;
    bt2.layer.borderWidth=0.4;
    
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 280, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64-280)];
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.github.com"]]];

}


- (void)btAction{
#if defined(DEBUG)||defined(_DEBUG)
    NEHTTPEyeViewController *vc=[[NEHTTPEyeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
#endif

    
    
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)bt1Action{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/search/users?q=language:objective-c&sort=followers&order=desc"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];

}

- (void)bt2Action{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/yy"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    
}


- (void)testRequest {

    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/AFNetworking/2.5.4/AFNetworking.podspec.json"]];
    [postRequest setHTTPMethod:@"POST"];
        [postRequest setAllHTTPHeaderFields:@{@"Content-Type":@"2"}];
    NSData *postData = [@"key1=value1&key2=value2" dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    
    //404
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/xx"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];

    
}
#pragma clang diagnostic pop


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
