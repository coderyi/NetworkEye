//
//  NEHTTPModelManager.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPModelManager.h"

#import "NEShakeGestureManager.h"
#import "NEHTTPModel.h"
#include "sqlite3.h"

#define kSTRDoubleMarks @"\""
#define kSQLDoubleMarks @"\"\""
#define kSTRShortMarks  @"'"
#define kSQLShortMarks  @"''"

@implementation NEHTTPModelManager

- (id)init {
    self = [super init];
    if (self) {
        _sqlitePassword=kSQLitePassword;
        self.saveRequestMaxCount=kSaveRequestMaxCount;
    }
    return self;
}

+ (NEHTTPModelManager *)defaultManager {
    
    static NEHTTPModelManager *staticManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticManager=[[NEHTTPModelManager alloc] init];
        [staticManager createTable];
    });
    return staticManager;
    
}

+ (NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *ducumentsDirectory = [paths objectAtIndex:0];
    NSString *str=[[NSString alloc] initWithFormat:@"%@/networkeye.sqlite",ducumentsDirectory];
    return  str;
}

- (void)createTable {
    
    NSMutableString *init_sqls=[NSMutableString stringWithCapacity:1024];
    [init_sqls appendFormat:@"create table if not exists nenetworkhttpeyes(myID double primary key,startDateString text,endDateString text,requestURLString text,requestCachePolicy text,requestTimeoutInterval double,requestHTTPMethod text,requestAllHTTPHeaderFields text,requestHTTPBody text,responseMIMEType text,responseExpectedContentLength text,responseTextEncodingName text,responseSuggestedFilename text,responseStatusCode int,responseAllHeaderFields text,receiveJSONData text);"];
    
    FMDatabaseQueue *queue= [FMDatabaseQueue databaseQueueWithPath:[NEHTTPModelManager filename]];
    [queue inDatabase:^(FMDatabase *db) {
        [db setKey:_sqlitePassword];
        [db executeUpdate:init_sqls];
    }];
    
}

- (void)addModel:(NEHTTPModel *) aModel {
    
    if ([aModel.responseMIMEType isEqualToString:@"text/html"]) {
        aModel.receiveJSONData=@"";
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"nenetworkhttpeyecache"] isEqualToString:@"a"]) {
        [self deleteAllItem];
        [[NSUserDefaults standardUserDefaults] setObject:@"b" forKey:@"nenetworkhttpeyecache"];
    }

    FMDatabaseQueue *queue= [FMDatabaseQueue databaseQueueWithPath:[NEHTTPModelManager filename]];
    BOOL isNull;
    isNull=(aModel.receiveJSONData==nil);
    if (isNull) {
        aModel.receiveJSONData=@"";
    }
    NSString *receiveJSONData;
    receiveJSONData=[self stringToSQLFilter:aModel.receiveJSONData];
    NSString *sql=[NSString stringWithFormat:@"insert into nenetworkhttpeyes values('%lf','%@','%@','%@','%@','%lf','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@')",aModel.myID,aModel.startDateString,aModel.endDateString,aModel.requestURLString,aModel.requestCachePolicy,aModel.requestTimeoutInterval,aModel.requestHTTPMethod,aModel.requestAllHTTPHeaderFields,aModel.requestHTTPBody,aModel.responseMIMEType,aModel.responseExpectedContentLength,aModel.responseTextEncodingName,aModel.responseSuggestedFilename,aModel.responseStatusCode,[self stringToSQLFilter:aModel.responseAllHeaderFields],receiveJSONData];
    [queue inDatabase:^(FMDatabase *db) {
        [db setKey:_sqlitePassword];
        [db executeUpdate:sql];
    }];
    
    return ;
    
}

- (NSMutableArray *)allobjects {
    
    FMDatabaseQueue *queue= [FMDatabaseQueue databaseQueueWithPath:[NEHTTPModelManager filename]];
    NSString *sql =[NSString stringWithFormat:@"select * from nenetworkhttpeyes order by myID desc"];
    NSMutableArray *array=[NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        [db setKey:_sqlitePassword];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NEHTTPModel *model=[[NEHTTPModel alloc] init];
            model.myID=[rs doubleForColumn:@"myID"];
            model.startDateString=[rs stringForColumn:@"startDateString"];
            model.endDateString=[rs stringForColumn:@"endDateString"];
            model.requestURLString=[rs stringForColumn:@"requestURLString"];
            model.requestCachePolicy=[rs stringForColumn:@"requestCachePolicy"];
            model.requestTimeoutInterval=[rs doubleForColumn:@"requestTimeoutInterval"];
            model.requestHTTPMethod=[rs stringForColumn:@"requestHTTPMethod"];
            model.requestAllHTTPHeaderFields=[rs stringForColumn:@"requestAllHTTPHeaderFields"];
            model.requestHTTPBody=[rs stringForColumn:@"requestHTTPBody"];
            model.responseMIMEType=[rs stringForColumn:@"responseMIMEType"];
            model.responseExpectedContentLength=[rs stringForColumn:@"responseExpectedContentLength"];
            model.responseTextEncodingName=[rs stringForColumn:@"responseTextEncodingName"];
            model.responseSuggestedFilename=[rs stringForColumn:@"responseSuggestedFilename"];
            model.responseStatusCode=[rs intForColumn:@"responseStatusCode"];
            model.responseAllHeaderFields=[self stringToSQLFilter:[rs stringForColumn:@"responseAllHeaderFields"]];
            model.receiveJSONData=[self stringToOBJFilter:[rs stringForColumn:@"receiveJSONData"]];
            [array addObject:model];
        }
    }];
    
    if (array.count>=self.saveRequestMaxCount) {
        [[NSUserDefaults standardUserDefaults] setObject:@"a" forKey:@"nenetworkhttpeyecache"];
    }
    
    return array;
    
}

- (void) deleteAllItem {
    
    NSString *sql=[NSString stringWithFormat:@"delete from nenetworkhttpeyes"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NEHTTPModelManager filename]];
    [queue inDatabase:^(FMDatabase *db) {
        [db setKey:_sqlitePassword];
        [db executeUpdate:sql];
    }];
    
    return ;
    
}


#pragma mark - Utils

- (id)stringToSQLFilter:(id)str {
    
    if ( [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSTRShortMarks withString:kSQLShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSTRDoubleMarks withString:kSQLDoubleMarks];
        return temp;
    }
    return str;
    
}

- (id)stringToOBJFilter:(id)str {
    
    if ( [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSQLShortMarks withString:kSTRShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSQLDoubleMarks withString:kSTRDoubleMarks];
        return temp;
    }
    return str;
    
}

@end
