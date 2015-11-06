//
//  UIWindow+NEShakeGesture.m
//  NetworkEye
//
//  Created by coderyi on 15/11/6.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "UIWindow+NEShakeGesture.h"
#import "NEShakeGestureManager.h"
@implementation UIWindow (NEShakeGesture)
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
        //        [BUGViewController showHideDebugWindow];
        [[NEShakeGestureManager defaultManager] showAlertView];
        
    }
}
@end
