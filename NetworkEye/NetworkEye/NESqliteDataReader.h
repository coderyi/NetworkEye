//
//  NESqliteDataReader.h
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface NESqliteDataReader : NSObject{
    sqlite3_stmt *statement;
}

- (id)initWithStatement:(sqlite3_stmt *)statement;
//移动读指针到下一行数据，返回NO表示已读到尾部
- (BOOL) read;
//读取对应列的整型值
- (int) integerValueForColumnIndex:(NSUInteger) columnIndex;
//读取对应列的小数值
- (double) doubleValueForColumnIndex:(NSUInteger) columnIndex;
//读取对应列的文本值
- (NSString *) stringValueForColumnIndex:(NSUInteger) columnIndex;
//关闭并释放statement
- (void) close;



@end
