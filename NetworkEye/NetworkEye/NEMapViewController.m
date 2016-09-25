//
//  NEMapViewController.m
//  NetworkEye
//
//  Created by coderyi on 16/9/25.
//  Copyright © 2016年 coderyi. All rights reserved.
//

#import "NEMapViewController.h"
#import "NEHTTPModel.h"
#import "NEHTTPModelManager.h"
@interface NEMapViewController (){
    
    UITextView *mainTextView;
    
}


@end

@implementation NEMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
    [self.view addSubview:bar];
    bar.barTintColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    
    UIButton *backBt=[UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame=CGRectMake(10, 27, 40, 30);
    [backBt setTitle:@"back" forState:UIControlStateNormal];
    backBt.titleLabel.font=[UIFont systemFontOfSize:15];
    [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(backBtAction) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBt];
    
    UIButton *deleteBt=[UIButton buttonWithType:UIButtonTypeCustom];
    deleteBt.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-60, 27, 50, 30);
    [deleteBt setTitle:@"delete" forState:UIControlStateNormal];
    deleteBt.titleLabel.font=[UIFont systemFontOfSize:13];
    [deleteBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    if (_model.mapJSONData.length>0) {
        [bar addSubview:deleteBt];
    }
    
    
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(([[UIScreen mainScreen] bounds].size.width-230)/2, 20, 230, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:13.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    [bar addSubview:titleText];
    NSRange requestPathRange = [_model.requestURLString rangeOfString:@"?"];
    NSString *requestPath;
    if (requestPathRange.location == NSNotFound) {
        requestPath =_model.requestURLString;
    }else {
        requestPath = [_model.requestURLString substringToIndex:requestPathRange.location];
    }
    _model.mapPath = requestPath ;
    titleText.text=requestPath;
    titleText.lineBreakMode = NSLineBreakByTruncatingHead;
    
    mainTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    [self.view addSubview:mainTextView];
    mainTextView.text=_model.mapJSONData;
    
}

- (void)backBtAction {
    if (![[mainTextView.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:_model.mapJSONData]) {

        _model.mapJSONData = [mainTextView.text stringByTrimmingCharactersInSet:
                                                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [[NEHTTPModelManager defaultManager] addMapObject:_model];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)rightAction {
    [[NEHTTPModelManager defaultManager] removeMapObject:_model];
}


@end
