//
//  NEKeyboardShortcutManager.h
//  NetworkEye
//
//  Created by coderyi on 2016/10/15.
//  Copyright © 2016年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if TARGET_OS_SIMULATOR

@interface NEKeyboardShortcutManager : NSObject
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

+ (instancetype)sharedManager;

- (void)registerSimulatorShortcutWithKey:(NSString *)key modifiers:(UIKeyModifierFlags)modifiers action:(dispatch_block_t)action description:(NSString *)description;

@end
#endif
