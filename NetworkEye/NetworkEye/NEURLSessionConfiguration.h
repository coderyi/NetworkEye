//
//  NEURLSessionConfiguration.h
//  NetworkEye
//
//  Created by coderyi on 15/11/9.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEURLSessionConfiguration : NSObject
@property (nonatomic,assign) BOOL isSwizzle;
+(NEURLSessionConfiguration *)defaultConfiguration;
- (void)load;
- (void)unload;
@end
