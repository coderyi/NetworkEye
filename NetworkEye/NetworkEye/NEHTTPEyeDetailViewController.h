//
//  NEHTTPEyeDetailViewController.h
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEHTTPModel;

@interface NEHTTPEyeDetailViewController : UIViewController
/**
 *  detail page's data model,about request,response and data
 */
@property (nonatomic,strong) NEHTTPModel *model;

@end
