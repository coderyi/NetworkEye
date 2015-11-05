//
//  NESqliteDatabase.h
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "NESqliteDataReader.h"
#import "NEHTTPEye.h"
@interface NESqliteDatabase : NSObject{
    NSString *filename;//数据库文件路径
    sqlite3 *database;
}
- (id)initWithFilename:(NSString *)filename;
//打开数据库
- (int) open;
//关闭数据库
- (void) close;
//执行 insert,update,delete 等非查询SQL语句，该方法自动打开和关闭数据库
- (int) executeNonQuery:(NSString *) sql error:(NSError **) error;
//执行 insert,update,delete 等非查询SQL语句，参数openAutomatically指示是否自动打开和关闭数据库
- (int) executeNonQuery:(NSString *) sql openAutomatically:(BOOL) openAutomaticlly  error:(NSError **) error;
//执行 insert SQL语句，并输出插入的主键编号，该方法自动打开和关闭数据库
- (int) executeNonQuery:(NSString *) sql outputLastInsertRowId:(int *) lastInsertRowId  error:(NSError **) error;
//执行 select 查询SQL语句
- (NESqliteDataReader *) executeQuery:(NSString *) sql;

@end
