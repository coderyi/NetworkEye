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
        [[NEShakeGestureManager defaultManager] showAlertView];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    int twoFingerTag=NO;
    if ([event allTouches].count==2) {
        for (UITouch *touch in [event allTouches]) {
            if (touch.tapCount==1) {
                twoFingerTag=YES;
            }else{
                twoFingerTag=NO;
            }
        }
    }
    if (twoFingerTag) {
        [[NEShakeGestureManager defaultManager] showAlertView];
    }
    
}
@end
