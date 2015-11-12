//
//  NEHTTPModelManager.h
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "NEHTTPEye.h"
@class NEHTTPModel;
@interface NEHTTPModelManager : NSObject
{
    FMDatabaseQueue *sqliteDatabase;
    NSMutableArray *allobjects;
}

+(NSString *)filename;
+(NEHTTPModelManager *)defaultManager;
+(void)createTable;
-(int)addModel:(NEHTTPModel *) aModel error:(NSError **) error;
-(NSMutableArray *)allobjects;
- (int) deleteAllItem:(NSError **) error;
@end
