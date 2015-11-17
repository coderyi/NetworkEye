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
    [self setupView];
    [self testRequest];
    
}

- (void)setupView{

    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"NetworkEye";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, [[UIScreen mainScreen] bounds].size.width-20, 45)];
    [self.view addSubview:label];
    label.textColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    label.font=[UIFont systemFontOfSize:12];
    label.numberOfLines=0;
    label.text=@"NetworkEye - a iOS network debug library";
    label.textAlignment=NSTextAlignmentCenter;
    
    UIButton *btGoMonitorViewController=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btGoMonitorViewController];
    [btGoMonitorViewController addTarget:self action:@selector(goMonitorAction) forControlEvents:UIControlEventTouchUpInside];
    btGoMonitorViewController.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-160)/2, 80, 160, 45);
    [btGoMonitorViewController setTitle:@"Go NetworkEye" forState:UIControlStateNormal];
    [btGoMonitorViewController setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    btGoMonitorViewController.layer.borderColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f].CGColor;
    btGoMonitorViewController.layer.borderWidth=0.4;
    
    
    UIButton *btRightRequest=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btRightRequest];
    [btRightRequest addTarget:self action:@selector(btRightRequestAction) forControlEvents:UIControlEventTouchUpInside];
    btRightRequest.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-190)/2, 160, 190, 35);
    [btRightRequest setTitle:@"Click to right request" forState:UIControlStateNormal];
    [btRightRequest setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    btRightRequest.layer.borderColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f].CGColor;
    btRightRequest.layer.borderWidth=0.4;
    btRightRequest.titleLabel.font=[UIFont systemFontOfSize:15];

    UIButton *btErrorRequest=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btErrorRequest];
    [btErrorRequest addTarget:self action:@selector(btErrorRequestAction) forControlEvents:UIControlEventTouchUpInside];
    btErrorRequest.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-190)/2, 200, 190, 35);
    [btErrorRequest setTitle:@"Click to error request" forState:UIControlStateNormal];
    [btErrorRequest setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    btErrorRequest.layer.borderColor=[UIColor colorWithRed:0.9 green:0.31 blue:0.28 alpha:1].CGColor;
    btErrorRequest.layer.borderWidth=0.4;
    btErrorRequest.titleLabel.font=[UIFont systemFontOfSize:15];

    UIButton *btSessionRequest=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btSessionRequest];
    [btSessionRequest addTarget:self action:@selector(btSessionRequestAction) forControlEvents:UIControlEventTouchUpInside];
    btSessionRequest.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-190)/2, 240, 190, 35);
    [btSessionRequest setTitle:@"Click to session request" forState:UIControlStateNormal];
    [btSessionRequest setTitleColor:[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    btSessionRequest.layer.borderColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f].CGColor;
    btSessionRequest.layer.borderWidth=0.4;
    btSessionRequest.titleLabel.font=[UIFont systemFontOfSize:15];

    

    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 300, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64-330)];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.github.com"]]];
    
}

- (void)goMonitorAction{
    
#if defined(DEBUG)||defined(_DEBUG)
    NEHTTPEyeViewController *vc=[[NEHTTPEyeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
#endif
    

}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)btRightRequestAction{
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/search/users?q=language:objective-c&sort=followers&order=desc"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];

}

- (void)btErrorRequestAction{
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/yy"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
    
}
- (void)btSessionRequestAction{
    
    NSURL *url = [NSURL URLWithString:@"http://www.example.com"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    config.protocolClasses=@[[NEHTTPEye class]];//在NEURLSessionConfiguration里面注册了，所以不用在这里重复注册了
    
    NSURLSession *urlsession = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *datatask = [urlsession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"error: %@", error);
        }
        else {
            NSLog(@"Success");
        }
    }];
    [datatask resume];
    
    
    NSURLSessionDataTask *datatask1 = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://www.example1.com"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"error: %@", error);
        }
        else {
            NSLog(@"Success");
        }
    }];
    [datatask1 resume];
    
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
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[@"https://www.linkedin.com/countserv/count/share?url={google.com}&format=jsonp" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
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
