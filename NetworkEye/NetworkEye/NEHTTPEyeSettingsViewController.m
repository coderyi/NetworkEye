//
//  NEHTTPEyeSettingsViewController.m
//  NetworkEye
//
//  Created by coderyi on 15/11/12.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPEyeSettingsViewController.h"
#import "NEHTTPEye.h"
#import "NEHTTPModelManager.h"
@interface NEHTTPEyeSettingsViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{

    UITableView *mainTableView;
}

@end

@implementation NEHTTPEyeSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(([[UIScreen mainScreen] bounds].size.width-230)/2, 20, 230, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:15.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    [bar addSubview:titleText];
    titleText.text=@"settings";

    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:mainTableView];
    mainTableView.dataSource=self;
    mainTableView.delegate=self;
}
- (void)backBtAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        if (indexPath.row==0) {
            UISwitch *switch1=[[UISwitch alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-70, 7, 60, 40)];
            [cell.contentView addSubview:switch1];
            BOOL NetworkEyeEnable=[[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkEyeEnable"] boolValue];
            switch1.on=NetworkEyeEnable;
            [switch1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        }
    }
    cell.textLabel.font=[UIFont systemFontOfSize:12];

    if (indexPath.row==0) {
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=@"NetworkEye Enable";
    }else{
        cell.textLabel.textColor=[UIColor colorWithRed:0.88 green:0.22 blue:0.22 alpha:1];
        cell.textLabel.text=@"Clear Recorded Requests";
    }
    
    return cell;
    
}

- (void)switchAction:(UISwitch *)tempSwitch {
    [[NSUserDefaults standardUserDefaults] setDouble:tempSwitch.on forKey:@"NetworkEyeEnable"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NEHTTPEye setEnabled:tempSwitch.on];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"message" message:@"Are you sure to delete it" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"no", nil];
        [alertView show];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(buttonIndex==0){
        [[NEHTTPModelManager defaultManager] deleteAllItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
