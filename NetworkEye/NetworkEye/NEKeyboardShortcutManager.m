//
//  NEKeyboardShortcutManager.m
//  NetworkEye
//
//  Created by coderyi on 2016/10/15.
//  Copyright © 2016年 coderyi. All rights reserved.
//

#import "NEKeyboardShortcutManager.h"
#import <objc/runtime.h>
#import <objc/message.h>

#if TARGET_OS_SIMULATOR


@interface UIEvent (UIPhysicalKeyboardEvent)

@property (nonatomic, strong) NSString *_modifiedInput;
@property (nonatomic, strong) NSString *_unmodifiedInput;
@property (nonatomic, assign) UIKeyModifierFlags _modifierFlags;
@property (nonatomic, assign) BOOL _isKeyDown;
@property (nonatomic, assign) long _keyCode;

@end

@interface NEKeyInput : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, assign, readonly) UIKeyModifierFlags flags;

@end

@implementation NEKeyInput

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    if ([object isKindOfClass:[NEKeyInput class]]) {
        NEKeyInput *keyCommand = (NEKeyInput *)object;
        BOOL equalKeys = self.key == keyCommand.key || [self.key isEqual:keyCommand.key];
        BOOL equalFlags = self.flags == keyCommand.flags;
        isEqual = equalKeys && equalFlags;
    }
    return isEqual;
}

- (NSUInteger)hash
{
    return [self.key hash] ^ self.flags;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[self class] keyInputForKey:self.key flags:self.flags];
}


+ (instancetype)keyInputForKey:(NSString *)key flags:(UIKeyModifierFlags)flags
{
    NEKeyInput *keyInput = [[self alloc] init];
    if (keyInput) {
        keyInput->_key = key;
        keyInput->_flags = flags;
    }
    return keyInput;
}

@end

@interface NEKeyboardShortcutManager ()

@property (nonatomic, strong) NSMutableDictionary *actionsForKeyInputs;

@property (nonatomic, assign, getter=isPressingShift) BOOL pressingShift;
@property (nonatomic, assign, getter=isPressingCommand) BOOL pressingCommand;
@property (nonatomic, assign, getter=isPressingControl) BOOL pressingControl;

@end

@implementation NEKeyboardShortcutManager

+ (instancetype)sharedManager
{
    static NEKeyboardShortcutManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

+ (void)load
{
    SEL originalKeyEventSelector = NSSelectorFromString(@"handleKeyUIEvent:");
    SEL swizzledKeyEventSelector = [NEKeyboardShortcutManager swizzledSelectorForSelector:originalKeyEventSelector];
    
    void (^handleKeyUIEventSwizzleBlock)(UIApplication *, UIEvent *) = ^(UIApplication *slf, UIEvent *event) {
        
        [[[self class] sharedManager] handleKeyboardEvent:event];
        
        ((void(*)(id, SEL, id))objc_msgSend)(slf, swizzledKeyEventSelector, event);
    };
    
    [NEKeyboardShortcutManager replaceImplementationOfKnownSelector:originalKeyEventSelector onClass:[UIApplication class] withBlock:handleKeyUIEventSwizzleBlock swizzledSelector:swizzledKeyEventSelector];
    
    if ([[UITouch class] instancesRespondToSelector:@selector(maximumPossibleForce)]) {
        SEL originalSendEventSelector = NSSelectorFromString(@"sendEvent:");
        SEL swizzledSendEventSelector = [NEKeyboardShortcutManager swizzledSelectorForSelector:originalSendEventSelector];
        
        void (^sendEventSwizzleBlock)(UIApplication *, UIEvent *) = ^(UIApplication *slf, UIEvent *event) {
            if (event.type == UIEventTypeTouches) {
                NEKeyboardShortcutManager *keyboardManager = [NEKeyboardShortcutManager sharedManager];
                NSInteger pressureLevel = 0;
                if (keyboardManager.isPressingShift) {
                    pressureLevel++;
                }
                if (keyboardManager.isPressingCommand) {
                    pressureLevel++;
                }
                if (keyboardManager.isPressingControl) {
                    pressureLevel++;
                }
                if (pressureLevel > 0) {
                    for (UITouch *touch in [event allTouches]) {
                        double adjustedPressureLevel = pressureLevel * 20 * touch.maximumPossibleForce;
                        [touch setValue:@(adjustedPressureLevel) forKey:@"_pressure"];
                    }
                }
            }
            
            ((void(*)(id, SEL, id))objc_msgSend)(slf, swizzledSendEventSelector, event);
        };
        
        [NEKeyboardShortcutManager replaceImplementationOfKnownSelector:originalSendEventSelector onClass:[UIApplication class] withBlock:sendEventSwizzleBlock swizzledSelector:swizzledSendEventSelector];
        
        SEL originalSupportsTouchPressureSelector = NSSelectorFromString(@"_supportsForceTouch");
        SEL swizzledSupportsTouchPressureSelector = [NEKeyboardShortcutManager swizzledSelectorForSelector:originalSupportsTouchPressureSelector];
        
        BOOL (^supportsTouchPressureSwizzleBlock)(UIDevice *) = ^BOOL(UIDevice *slf) {
            return YES;
        };
        
        [NEKeyboardShortcutManager replaceImplementationOfKnownSelector:originalSupportsTouchPressureSelector onClass:[UIDevice class] withBlock:supportsTouchPressureSwizzleBlock swizzledSelector:swizzledSupportsTouchPressureSelector];
    }
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _actionsForKeyInputs = [NSMutableDictionary dictionary];
        _enabled = YES;
    }
    
    return self;
}

- (void)registerSimulatorShortcutWithKey:(NSString *)key modifiers:(UIKeyModifierFlags)modifiers action:(dispatch_block_t)action description:(NSString *)description
{
    NEKeyInput *keyInput = [NEKeyInput keyInputForKey:key flags:modifiers];
    [self.actionsForKeyInputs setObject:action forKey:keyInput];
}

static const long kNEControlKeyCode = 0xe0;
static const long kNEShiftKeyCode = 0xe1;
static const long kNECommandKeyCode = 0xe3;

- (void)handleKeyboardEvent:(UIEvent *)event
{
    if (!self.enabled) {
        return;
    }
    
    NSString *modifiedInput = nil;
    NSString *unmodifiedInput = nil;
    UIKeyModifierFlags flags = 0;
    BOOL isKeyDown = NO;
    
    if ([event respondsToSelector:@selector(_modifiedInput)]) {
        modifiedInput = [event _modifiedInput];
    }
    
    if ([event respondsToSelector:@selector(_unmodifiedInput)]) {
        unmodifiedInput = [event _unmodifiedInput];
    }
    
    if ([event respondsToSelector:@selector(_modifierFlags)]) {
        flags = [event _modifierFlags];
    }
    
    if ([event respondsToSelector:@selector(_isKeyDown)]) {
        isKeyDown = [event _isKeyDown];
    }
    
    BOOL interactionEnabled = ![[UIApplication sharedApplication] isIgnoringInteractionEvents];
    BOOL hasFirstResponder = NO;
    if (isKeyDown && [modifiedInput length] > 0 && interactionEnabled) {
        UIResponder *firstResponder = nil;
        for (UIWindow *window in [NEKeyboardShortcutManager allWindows]) {
            firstResponder = [window valueForKey:@"firstResponder"];
            if (firstResponder) {
                hasFirstResponder = YES;
                break;
            }
        }
        
        if (firstResponder) {
            if ([unmodifiedInput isEqual:UIKeyInputEscape]) {
                [firstResponder resignFirstResponder];
            }
        } else {
            NEKeyInput *exactMatch = [NEKeyInput keyInputForKey:unmodifiedInput flags:flags];
            
            dispatch_block_t actionBlock = self.actionsForKeyInputs[exactMatch];
            
            if (!actionBlock) {
                NEKeyInput *shiftMatch = [NEKeyInput keyInputForKey:modifiedInput flags:flags&(!UIKeyModifierShift)];
                actionBlock = self.actionsForKeyInputs[shiftMatch];
            }
            
            if (!actionBlock) {
                NEKeyInput *capitalMatch = [NEKeyInput keyInputForKey:[unmodifiedInput uppercaseString] flags:flags];
                actionBlock = self.actionsForKeyInputs[capitalMatch];
            }
            
            if (actionBlock) {
                actionBlock();
            }
        }
    }
    
    if (!hasFirstResponder && [event respondsToSelector:@selector(_keyCode)]) {
        long keyCode = [event _keyCode];
        if (keyCode == kNEControlKeyCode) {
            self.pressingControl = isKeyDown;
        } else if (keyCode == kNECommandKeyCode) {
            self.pressingCommand = isKeyDown;
        } else if (keyCode == kNEShiftKeyCode) {
            self.pressingShift = isKeyDown;
        }
    }
}

#pragma mark Utils

+ (NSArray *)allWindows
{
    BOOL includeInternalWindows = YES;
    BOOL onlyVisibleWindows = NO;
    
    NSArray *allWindowsComponents = @[@"al", @"lWindo", @"wsIncl", @"udingInt", @"ernalWin", @"dows:o", @"nlyVisi", @"bleWin", @"dows:"];
    SEL allWindowsSelector = NSSelectorFromString([allWindowsComponents componentsJoinedByString:@""]);
    
    NSMethodSignature *methodSignature = [[UIWindow class] methodSignatureForSelector:allWindowsSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    
    invocation.target = [UIWindow class];
    invocation.selector = allWindowsSelector;
    [invocation setArgument:&includeInternalWindows atIndex:2];
    [invocation setArgument:&onlyVisibleWindows atIndex:3];
    [invocation invoke];
    
    __unsafe_unretained NSArray *windows = nil;
    [invocation getReturnValue:&windows];
    return windows;
}

+ (SEL)swizzledSelectorForSelector:(SEL)selector
{
    return NSSelectorFromString([NSString stringWithFormat:@"_ne_swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}

+ (void)replaceImplementationOfKnownSelector:(SEL)originalSelector onClass:(Class)class withBlock:(id)block swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    if (!originalMethod) {
        return;
    }
    
    IMP implementation = imp_implementationWithBlock(block);
    class_addMethod(class, swizzledSelector, implementation, method_getTypeEncoding(originalMethod));
    Method newMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, newMethod);
}

@end


#endif
