//
//  NEHTTPEyeViewController.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPEyeViewController.h"
#import "NEHTTPModel.h"
#import "NEHTTPModelManager.h"
#import "NEHTTPEyeDetailViewController.h"
@interface NEHTTPEyeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView1;
    NSArray *httpRequests;
    
}

@end

@implementation NEHTTPEyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    
    if ([self.navigationController viewControllers].count<1) {
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
        tableView1.frame=CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
        
        
        UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(([[UIScreen mainScreen] bounds].size.width-120)/2, 20, 120, 44)];
        titleText.backgroundColor = [UIColor clearColor];
        titleText.textColor=[UIColor whiteColor];
        [titleText setFont:[UIFont systemFontOfSize:19.0]];
        titleText.textAlignment=NSTextAlignmentCenter;
        [bar addSubview:titleText];
        titleText.text=@"NetworkEye";
        
    }
    
    
    
   
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    
    httpRequests=[[NEHTTPModelManager defaultManager] allobjects];

}

- (void)backBtAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return httpRequests.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId1";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.textLabel.textColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    cell.textLabel.text=((NEHTTPModel *)((httpRequests)[indexPath.row])).requestURLString;

    
    
    
    NSAttributedString *responseStatusCode;
    NSAttributedString *requestHTTPMethod;
    UIColor *titleColor=[UIColor colorWithRed:0.96 green:0.15 blue:0.11 alpha:1];
    if (((NEHTTPModel *)((httpRequests)[indexPath.row])).responseStatusCode == 200) {
        titleColor=[UIColor colorWithRed:0.11 green:0.76 blue:0.13 alpha:1];
    }
    UIFont *titleFont=[UIFont systemFontOfSize:12.0];
    UIColor *detailColor=[UIColor blackColor];
    UIFont *detailFont=[UIFont systemFontOfSize:12.0];
    responseStatusCode = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d   ",((NEHTTPModel *)((httpRequests)[indexPath.row])).responseStatusCode]
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    requestHTTPMethod = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@   %@",((NEHTTPModel *)((httpRequests)[indexPath.row])).requestHTTPMethod,((NEHTTPModel *)((httpRequests)[indexPath.row])).responseMIMEType,[((NEHTTPModel *)((httpRequests)[indexPath.row])).startDateString substringFromIndex:5]]
                                                           attributes:@{
                                                                        NSFontAttributeName : detailFont,
                                                                        NSForegroundColorAttributeName: detailColor
                                                                        }];
    NSMutableAttributedString *detail=[[NSMutableAttributedString alloc] init];
    [detail appendAttributedString:responseStatusCode];
    [detail appendAttributedString:requestHTTPMethod];
    cell.detailTextLabel.attributedText=detail;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NEHTTPEyeDetailViewController *detail=[[NEHTTPEyeDetailViewController alloc] init];
    detail.model=(NEHTTPModel *)((httpRequests)[indexPath.row]);
    
    [self presentViewController:detail animated:YES completion:nil];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
