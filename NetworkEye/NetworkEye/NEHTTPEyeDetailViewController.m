//
//  NEHTTPEyeDetailViewController.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPEyeDetailViewController.h"
#import "NEHTTPModel.h"
@interface NEHTTPEyeDetailViewController (){

    UITextView *mainTextView;

}

@end

@implementation NEHTTPEyeDetailViewController

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
    [titleText setFont:[UIFont systemFontOfSize:13.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    [bar addSubview:titleText];
    titleText.text=_model.requestURLString;
    
    mainTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    [self.view addSubview:mainTextView];

    [self setupAttributedString];
}


- (void)setupAttributedString{

    NSAttributedString *startDateString;
    NSAttributedString *endDateString;
    NSAttributedString *requestURLString;
    NSAttributedString *requestCachePolicyString;
    NSAttributedString *requestTimeoutInterval;
    NSAttributedString *requestHTTPMethod;
    NSAttributedString *requestAllHTTPHeaderFields;
    NSAttributedString *requestHTTPBody;
    NSAttributedString *responseMIMEType;
    NSAttributedString *responseExpectedContentLength;
    NSAttributedString *responseTextEncodingName;
    NSAttributedString *responseSuggestedFilename;
    NSAttributedString *responseStatusCode;
    NSAttributedString *responseAllHeaderFields;
    NSAttributedString *receiveJSONData;
    
    NSAttributedString *startDateStringDetail;
    NSAttributedString *endDateStringDetail;
    NSAttributedString *requestURLStringDetail;
    NSAttributedString *requestCachePolicyStringDetail;
    NSAttributedString *requestTimeoutIntervalDetail;
    NSAttributedString *requestHTTPMethodDetail;
    NSAttributedString *requestAllHTTPHeaderFieldsDetail;
    NSAttributedString *requestHTTPBodyDetail;
    NSAttributedString *responseMIMETypeDetail;
    NSAttributedString *responseExpectedContentLengthDetail;
    NSAttributedString *responseTextEncodingNameDetail;
    NSAttributedString *responseSuggestedFilenameDetail;
    NSAttributedString *responseStatusCodeDetail;
    NSAttributedString *responseAllHeaderFieldsDetail;
    NSAttributedString *receiveJSONDataDetail;
    
    UIColor *titleColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    UIFont *titleFont=[UIFont systemFontOfSize:14.0];
    UIColor *detailColor=[UIColor blackColor];
    UIFont *detailFont=[UIFont systemFontOfSize:14.0];
    
    startDateString = [[NSMutableAttributedString alloc] initWithString:@"[startDate]:"
                                                       attributes:@{
                                                                    NSFontAttributeName : titleFont,
                                                                    NSForegroundColorAttributeName: titleColor
                                                                    }];

    endDateString = [[NSMutableAttributedString alloc] initWithString:@"[endDate]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    requestURLString = [[NSMutableAttributedString alloc] initWithString:@"[requestURL]\n"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    requestCachePolicyString = [[NSMutableAttributedString alloc] initWithString:@"[requestCachePolicy]\n"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    requestTimeoutInterval = [[NSMutableAttributedString alloc] initWithString:@"[requestTimeoutInterval]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    requestHTTPMethod = [[NSMutableAttributedString alloc] initWithString:@"[requestHTTPMethod]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    requestAllHTTPHeaderFields = [[NSMutableAttributedString alloc] initWithString:@"[requestAllHTTPHeaderFields]\n"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    requestHTTPBody = [[NSMutableAttributedString alloc] initWithString:@"[requestHTTPBody]\n"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    responseMIMEType = [[NSMutableAttributedString alloc] initWithString:@"[responseMIMEType]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    responseExpectedContentLength = [[NSMutableAttributedString alloc] initWithString:@"[responseExpectedContentLength]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    responseTextEncodingName = [[NSMutableAttributedString alloc] initWithString:@"[responseTextEncodingName]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    responseSuggestedFilename = [[NSMutableAttributedString alloc] initWithString:@"[responseSuggestedFilename]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    responseStatusCode = [[NSMutableAttributedString alloc] initWithString:@"[responseStatusCode]:"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    
    responseAllHeaderFields = [[NSMutableAttributedString alloc] initWithString:@"[responseAllHeaderFields]\n"
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    if ([_model.responseMIMEType isEqualToString:@"application/xml"] ||[_model.responseMIMEType isEqualToString:@"text/xml"]) {
        receiveJSONData = [[NSMutableAttributedString alloc] initWithString:@"[responseXML]\n"
                                                                 attributes:@{
                                                                              NSFontAttributeName : titleFont,
                                                                              NSForegroundColorAttributeName: titleColor
                                                                              }];
    }else {
        receiveJSONData = [[NSMutableAttributedString alloc] initWithString:@"[responseJSON]\n"
                                                                 attributes:@{
                                                                              NSFontAttributeName : titleFont,
                                                                              NSForegroundColorAttributeName: titleColor
                                                                              }];
    }
    
    
    
    
    //detail
    
    startDateStringDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.startDateString]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    
    endDateStringDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n",_model.endDateString]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    requestURLStringDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.requestURLString]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    
    requestCachePolicyStringDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.requestCachePolicy]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    
    requestTimeoutIntervalDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lf\n",_model.requestTimeoutInterval]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    
    requestHTTPMethodDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.requestHTTPMethod]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    requestAllHTTPHeaderFieldsDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.requestAllHTTPHeaderFields]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    
    requestHTTPBodyDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n",_model.requestHTTPBody]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    responseMIMETypeDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.responseMIMEType]
                                                             attributes:@{
                                                                          NSFontAttributeName : detailFont,
                                                                          NSForegroundColorAttributeName: detailColor
                                                                          }];
    responseExpectedContentLengthDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2lfKB\n",[_model.responseExpectedContentLength doubleValue]/1024.0]
                                                                   attributes:@{
                                                                                NSFontAttributeName : detailFont,
                                                                                NSForegroundColorAttributeName: detailColor
                                                                                }];
    responseTextEncodingNameDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.responseTextEncodingName]
                                                                    attributes:@{
                                                                                 NSFontAttributeName : detailFont,
                                                                                 NSForegroundColorAttributeName: detailColor
                                                                                 }];
    responseSuggestedFilenameDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_model.responseSuggestedFilename]
                                                                   attributes:@{
                                                                                NSFontAttributeName : detailFont,
                                                                                NSForegroundColorAttributeName: detailColor
                                                                                }];
    
   
    
    UIColor *statusDetailColor=[UIColor colorWithRed:0.96 green:0.15 blue:0.11 alpha:1];
    if (_model.responseStatusCode == 200) {
        statusDetailColor=[UIColor colorWithRed:0.11 green:0.76 blue:0.13 alpha:1];
    }
    responseStatusCodeDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d\n",_model.responseStatusCode]
                                                                    attributes:@{
                                                                                 NSFontAttributeName : detailFont,
                                                                                 NSForegroundColorAttributeName: statusDetailColor
                                                                                 }];
    
    responseAllHeaderFieldsDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n",_model.responseAllHeaderFields]
                                                                             attributes:@{
                                                                                          NSFontAttributeName : detailFont,
                                                                                          NSForegroundColorAttributeName: detailColor
                                                                                          }];
    

        NSString *transString = [[self class] replaceUnicode:_model.receiveJSONData];
    receiveJSONDataDetail = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n",transString]
                                                                      attributes:@{
                                                                                   NSFontAttributeName : detailFont,
                                                                                   NSForegroundColorAttributeName: detailColor
                                                                                   }];
    
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];
    
    [attrText appendAttributedString:startDateString];
    [attrText appendAttributedString:startDateStringDetail];

    [attrText appendAttributedString:endDateString];
    [attrText appendAttributedString:endDateStringDetail];

    [attrText appendAttributedString:requestURLString];
    [attrText appendAttributedString:requestURLStringDetail];
    
    [attrText appendAttributedString:requestCachePolicyString];
    [attrText appendAttributedString:requestCachePolicyStringDetail];
    
    [attrText appendAttributedString:requestTimeoutInterval];
    [attrText appendAttributedString:requestTimeoutIntervalDetail];
    
    [attrText appendAttributedString:requestHTTPMethod];
    [attrText appendAttributedString:requestHTTPMethodDetail];
    
    [attrText appendAttributedString:requestAllHTTPHeaderFields];
    [attrText appendAttributedString:requestAllHTTPHeaderFieldsDetail];
    
    [attrText appendAttributedString:requestHTTPBody];
    [attrText appendAttributedString:requestHTTPBodyDetail];
    
    [attrText appendAttributedString:responseMIMEType];
    [attrText appendAttributedString:responseMIMETypeDetail];
    
    [attrText appendAttributedString:responseExpectedContentLength];
    [attrText appendAttributedString:responseExpectedContentLengthDetail];
    
    [attrText appendAttributedString:responseTextEncodingName];
    [attrText appendAttributedString:responseTextEncodingNameDetail];
    
    [attrText appendAttributedString:responseSuggestedFilename];
    [attrText appendAttributedString:responseSuggestedFilenameDetail];
    
    [attrText appendAttributedString:responseStatusCode];
    [attrText appendAttributedString:responseStatusCodeDetail];
    
    [attrText appendAttributedString:responseAllHeaderFields];
    [attrText appendAttributedString:responseAllHeaderFieldsDetail];
    
    [attrText appendAttributedString:receiveJSONData];
    [attrText appendAttributedString:receiveJSONDataDetail];

    mainTextView.attributedText=attrText;
    
}
- (void)backBtAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Utils

//unicode to utf-8
+ (NSString*) replaceUnicode:(NSString*)aUnicodeString {
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                          mutabilityOption:NSPropertyListImmutable
                           
                                                                    format:NULL
                           
                                                          errorDescription:NULL];
#pragma clang diagnostic pop
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}

@end
