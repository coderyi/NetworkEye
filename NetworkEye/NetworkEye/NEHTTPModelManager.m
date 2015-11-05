//
//  NEHTTPModelManager.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPModelManager.h"
#import "NEShakeGestureManager.h"
#import "NESqliteDatabase.h"
#import "NEHTTPModel.h"
#include "sqlite3.h"


#define kSTRDoubleMarks @"\""
#define kSQLDoubleMarks @"\"\""
#define kSTRShortMarks  @"'"
#define kSQLShortMarks  @"''"
static NEHTTPModelManager *staticManager;
@implementation NEHTTPModelManager

+ (NSString *)filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *ducumentsDirectory = [paths objectAtIndex:0];
    NSString *str=[[NSString alloc] initWithFormat:@"%@/networkeye.sqlite",ducumentsDirectory];
    return  str;
}


+(void)createTable{
    
    NSMutableString *init_sqls=[NSMutableString stringWithCapacity:1024];
    [init_sqls appendFormat:@"create table if not exists nenetworkhttpeyes(myID double primary key,startDateString text,endDateString text,requestURLString text,requestCachePolicy text,requestTimeoutInterval double,requestHTTPMethod text,requestAllHTTPHeaderFields text,requestHTTPBody text,responseMIMEType text,responseExpectedContentLength text,responseTextEncodingName text,responseSuggestedFilename text,responseStatusCode int,responseAllHeaderFields text,receiveJSONData text);"];
    
    
    
    
    
    NESqliteDatabase *db=[[NESqliteDatabase alloc] initWithFilename:[NEHTTPModelManager filename]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
        [db executeNonQuery:init_sqls error:nil];

    });

}


+(NEHTTPModelManager *)defaultManager{
    
    if (staticManager==nil) {
        staticManager=[[NEHTTPModelManager alloc] init];
        [NEHTTPModelManager createTable];
        NEShakeGestureManager *hooker=[[NEShakeGestureManager alloc] init];
        [hooker install];
    }
    return staticManager;
}
-(int)addModel:(NEHTTPModel *) aModel error:(NSError **) error{
    if ([aModel.responseMIMEType isEqualToString:@"text/html"]) {
        aModel.receiveJSONData=@"";
        
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"nenetworkhttpeyecache"] isEqualToString:@"a"]) {
        [self deleteAllItem:nil];
        [[NSUserDefaults standardUserDefaults] setObject:@"b" forKey:@"nenetworkhttpeyecache"];
    }
    BOOL isRead=NO;
    int i;
    int rc;
//    sqliteDatabase=[[NESqliteDatabase alloc] initWithFilename:[NEHTTPModelManager filename]];
//    
//    [sqliteDatabase open];
//    NSString *sql =[NSString stringWithFormat:@"select * from nenetworkhttpeyes where myID='%lf'",aModel.myID];
//    
//    NESqliteDataReader *dr=[sqliteDatabase executeQuery:sql];
//    
//    isRead=[dr read];
//    [dr close];
//    [sqliteDatabase close];
    if (isRead) {
        i=1;
        return 1;
        
    }else{
        i=0;
        sqliteDatabase=[[NESqliteDatabase alloc] initWithFilename:[NEHTTPModelManager filename]];

        BOOL isNull;
        isNull=(aModel.receiveJSONData==nil);
        
        
        if (isNull) {
            aModel.receiveJSONData=@"";
        }

//        NSString *sql=[NSString stringWithFormat:@"insert into nenetworkhttpeyes values('%lf','%@','%@','%@','%@','%lf','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@')",aModel.myID,aModel.startDateString,aModel.endDateString,aModel.requestURLString,aModel.requestCachePolicy,aModel.requestTimeoutInterval,aModel.requestHTTPMethod,aModel.requestAllHTTPHeaderFields,aModel.requestHTTPBody,aModel.responseMIMEType,aModel.responseExpectedContentLength,aModel.responseTextEncodingName,aModel.responseSuggestedFilename,aModel.responseStatusCode,[self stringToSQLFilter:aModel.responseAllHeaderFields],[self stringToSQLFilter:aModel.receiveJSONData]];
        NSString *receiveJSONData;
        
        receiveJSONData=[self stringToSQLFilter:aModel.receiveJSONData];
        
                NSString *sql=[NSString stringWithFormat:@"insert into nenetworkhttpeyes values('%lf','%@','%@','%@','%@','%lf','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@')",aModel.myID,aModel.startDateString,aModel.endDateString,aModel.requestURLString,aModel.requestCachePolicy,aModel.requestTimeoutInterval,aModel.requestHTTPMethod,aModel.requestAllHTTPHeaderFields,aModel.requestHTTPBody,aModel.responseMIMEType,aModel.responseExpectedContentLength,aModel.responseTextEncodingName,aModel.responseSuggestedFilename,aModel.responseStatusCode,[self stringToSQLFilter:aModel.responseAllHeaderFields],receiveJSONData];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // something
            int result;
            result=[sqliteDatabase executeNonQuery:sql error:error];
            if (result!=0) {
                
                NSLog(@"add model to sqlite error:url is %@ ",aModel.requestURLString);
            }
        });
        
        
    }
    return i;
}



-(NSMutableArray *)allobjects{
    
    sqliteDatabase=[[NESqliteDatabase alloc] initWithFilename:[NEHTTPModelManager filename]];
    
    [sqliteDatabase open];
    NSString *sql =[NSString stringWithFormat:@"select * from nenetworkhttpeyes order by myID desc"];
    NESqliteDataReader *dr= [sqliteDatabase executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    if (dr!=nil){
        while ([dr read]) {
            NEHTTPModel *model=[[NEHTTPModel alloc] init];
            model.myID=[dr doubleValueForColumnIndex:0];
            model.startDateString=[dr stringValueForColumnIndex:1];
            model.endDateString=[dr stringValueForColumnIndex:2];
            model.requestURLString=[dr stringValueForColumnIndex:3];
            model.requestCachePolicy=[dr stringValueForColumnIndex:4];
            model.requestTimeoutInterval=[dr doubleValueForColumnIndex:5];
            model.requestHTTPMethod=[dr stringValueForColumnIndex:6];
            model.requestAllHTTPHeaderFields=[dr stringValueForColumnIndex:7];
            model.requestHTTPBody=[dr stringValueForColumnIndex:8];
            
            model.responseMIMEType=[dr stringValueForColumnIndex:9];
            model.responseExpectedContentLength=[dr stringValueForColumnIndex:10];
            model.responseTextEncodingName=[dr stringValueForColumnIndex:11];
            model.responseSuggestedFilename=[dr stringValueForColumnIndex:12];
            model.responseStatusCode=[dr integerValueForColumnIndex:13];
            model.responseAllHeaderFields=[self stringToSQLFilter:[dr stringValueForColumnIndex:14]];
            model.receiveJSONData=[self stringToOBJFilter:[dr stringValueForColumnIndex:15]];
           


            [array addObject:model];
        }
        [dr close];
    }
    [sqliteDatabase close];
    if (array.count>=kSaveRequestMaxCount) {
        [[NSUserDefaults standardUserDefaults] setObject:@"a" forKey:@"nenetworkhttpeyecache"];
    }
    return array;
    
}
- (int) deleteAllItem:(NSError **) error{
    sqliteDatabase=[[NESqliteDatabase alloc] initWithFilename:[NEHTTPModelManager filename]];
    NSString *sql=[NSString stringWithFormat:@"delete from nenetworkhttpeyes"];
    int rc=[sqliteDatabase executeNonQuery:sql error:error];
    
    
    
    return rc;
}

#pragma mark - Utils

-(id)stringToSQLFilter:(id)str{
    if ( [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSTRShortMarks withString:kSQLShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSTRDoubleMarks withString:kSQLDoubleMarks];
        return temp;
    }
    return str;
}

-(id)stringToOBJFilter:(id)str{
    if ( [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSQLShortMarks withString:kSTRShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSQLDoubleMarks withString:kSTRDoubleMarks];
        return temp;
    }
    return str;
}
@end
