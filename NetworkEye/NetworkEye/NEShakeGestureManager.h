//
//  NEShakeGestureManager.h
//  NetworkEye
//
//  Created by coderyi on 15/11/5.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEShakeGestureManager : NSObject

/**
 *  get NEShakeGestureManager's singleton object
 *
 *  @return singleton object
 */
+ (NEShakeGestureManager *)defaultManager;

/**
 *  show Go NetworkEye page 's alertView
 */
- (void)showAlertView;

@end
