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
#import "NEHTTPEyeSettingsViewController.h"
@interface NEHTTPEyeViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate> {
    UITableView *mainTableView;
    NSArray *httpRequests;
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
    NSArray *filterHTTPRequests;
}

@end

@implementation NEHTTPEyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:mainTableView];
    
    double flowCount=[[[NSUserDefaults standardUserDefaults] objectForKey:@"flowCount"] doubleValue];
    if (!flowCount) {
        flowCount=0.0;
    }
    UIColor *titleColor=[UIColor whiteColor];
    UIFont *titleFont=[UIFont systemFontOfSize:18.0];
    UIColor *detailColor=[UIColor whiteColor];
    UIFont *detailFont=[UIFont systemFontOfSize:12.0];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@"NetworkEye\n"
                                                                                    attributes:@{
                                                                                                 NSFontAttributeName : titleFont,
                                                                                                 NSForegroundColorAttributeName: titleColor
                                                                                                 }];
    
    NSMutableAttributedString *flowCountString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"流量共%.1lfMB",flowCount]
                                                                                        attributes:@{
                                                                                                     NSFontAttributeName : detailFont,
                                                                                                     NSForegroundColorAttributeName: detailColor
                                                                                                     }];
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];
    [attrText appendAttributedString:titleString];
    [attrText appendAttributedString:flowCountString];
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(([[UIScreen mainScreen] bounds].size.width-120)/2, 20, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    titleText.textAlignment=NSTextAlignmentCenter;
    titleText.numberOfLines=0;
    titleText.attributedText=attrText;
    
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
        
        UIButton *settingsBt=[UIButton buttonWithType:UIButtonTypeCustom];
        settingsBt.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-60, 27, 50, 30);
        [settingsBt setTitle:@"settings" forState:UIControlStateNormal];
        settingsBt.titleLabel.font=[UIFont systemFontOfSize:13];
        [settingsBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [settingsBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:settingsBt];
        mainTableView.frame=CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
        [bar addSubview:titleText];
    }else{
        titleText.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-120)/2, 0, 120, 44);
        [self.navigationController.navigationBar addSubview:titleText];
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"settings" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        self.navigationItem.rightBarButtonItem=right;
    }

    [self setupSearch];
    mainTableView.dataSource=self;
    mainTableView.delegate=self;
    httpRequests=[[[[NEHTTPModelManager defaultManager] allobjects] reverseObjectEnumerator] allObjects];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    httpRequests=[[[[NEHTTPModelManager defaultManager] allobjects] reverseObjectEnumerator] allObjects];
    [mainTableView reloadData];
}

- (void)rightAction {
    NEHTTPEyeSettingsViewController *settings = [[NEHTTPEyeSettingsViewController alloc] init];
    [self presentViewController:settings animated:YES completion:nil];
}

- (void)setupSearch {
    
    filterHTTPRequests=[[NSArray alloc] init];
    mySearchBar = [[UISearchBar alloc] init];
    
    mySearchBar.delegate = self;
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    mainTableView.tableHeaderView = mySearchBar;
    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    [mySearchDisplayController setDelegate:self];
    [mySearchDisplayController setSearchResultsDataSource:self];
    [mySearchDisplayController setSearchResultsDelegate:self];

}
- (void)backBtAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == mySearchDisplayController.searchResultsTableView) {
        return filterHTTPRequests.count;
    }
    return httpRequests.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.textLabel.textColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    NEHTTPModel *currenModel=[self modelForTableView:tableView atIndexPath:indexPath];
    
    cell.textLabel.text=currenModel.requestURLString;

    NSAttributedString *responseStatusCode;
    NSAttributedString *requestHTTPMethod;
    UIColor *titleColor=[UIColor colorWithRed:0.96 green:0.15 blue:0.11 alpha:1];
    if (currenModel.responseStatusCode == 200) {
        titleColor=[UIColor colorWithRed:0.11 green:0.76 blue:0.13 alpha:1];
    }
    UIFont *titleFont=[UIFont systemFontOfSize:12.0];
    UIColor *detailColor=[UIColor blackColor];
    UIFont *detailFont=[UIFont systemFontOfSize:12.0];
    responseStatusCode = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d   ",currenModel.responseStatusCode]
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    requestHTTPMethod = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@   %@",currenModel.requestHTTPMethod,currenModel.responseMIMEType,[((NEHTTPModel *)((httpRequests)[indexPath.row])).startDateString substringFromIndex:5]]
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NEHTTPEyeDetailViewController *detail = [[NEHTTPEyeDetailViewController alloc] init];
    detail.model = [self modelForTableView:tableView atIndexPath:indexPath];
    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if ([self.navigationController viewControllers].count>0) {
        return YES;
    }
    //准备搜寻前，把上面调整的TableView调整回全屏幕的状态
    [UIView animateWithDuration:0.2 animations:^{
        mainTableView.frame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-20);
        
    }];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    if ([self.navigationController viewControllers].count>0) {
        return YES;
    }
    if (searchBar.text.length<1) {
        [UIView animateWithDuration:0.2 animations:^{
            mainTableView.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
        }];
    }
    //当按下search按钮后 后走这里，并且这之后按cancel按钮不会走这里；当没有按过search按钮，按cancel按钮会走这里
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if ([self.navigationController viewControllers].count>0) {
        return ;
    }
    [UIView animateWithDuration:0.2 animations:^{
        mainTableView.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
    }];
}
#pragma mark - UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self updateSearchResultsWithSearchString:searchString];
    return YES;
}

- (void)updateSearchResultsWithSearchString:(NSString *)searchString {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *tempFilterHTTPRequests = [httpRequests filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NEHTTPModel *httpRequest, NSDictionary *bindings) {
            return [[NSString stringWithFormat:@"%@ %d %@ %@",httpRequest.requestURLString,httpRequest.responseStatusCode,httpRequest.requestHTTPMethod,httpRequest.responseMIMEType] rangeOfString:searchString options:NSCaseInsensitiveSearch].length > 0;
        }]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([mySearchDisplayController.searchBar.text isEqual:searchString]) {
                filterHTTPRequests = tempFilterHTTPRequests;
                [mySearchDisplayController.searchResultsTableView reloadData];
            }
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (NEHTTPModel *)modelForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NEHTTPModel *currenModel=[[NEHTTPModel alloc] init];
    if (tableView == mySearchDisplayController.searchResultsTableView) {
        currenModel=(NEHTTPModel *)((filterHTTPRequests)[indexPath.row]);
    }else{
        currenModel=(NEHTTPModel *)((httpRequests)[indexPath.row]);
    }
    return currenModel;
}

@end
