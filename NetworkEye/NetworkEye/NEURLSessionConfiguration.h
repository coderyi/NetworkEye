//
//  NEURLSessionConfiguration.h
//  NetworkEye
//
//  Created by coderyi on 15/11/9.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEURLSessionConfiguration : NSObject
@property (nonatomic,assign) BOOL isSwizzle;// whether swizzle NSURLSessionConfiguration's protocolClasses method

/**
 *  get NEURLSessionConfiguration's singleton object
 *
 *  @return singleton object
 */
+ (NEURLSessionConfiguration *)defaultConfiguration;

/**
 *  swizzle NSURLSessionConfiguration's protocolClasses method
 */
- (void)load;

/**
 *  make NSURLSessionConfiguration's protocolClasses method is normal
 */
- (void)unload;
@end
