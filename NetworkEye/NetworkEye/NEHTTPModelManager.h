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

@property(nonatomic,strong) NSString *sqlitePassword;
@property(nonatomic,assign) int saveRequestMaxCount;

/**
 *  get recorded requests 's SQLite filename
 *
 *  @return filename
 */
+ (NSString *)filename;

/**
 *  get NEHTTPModelManager's singleton object
 *
 *  @return singleton object
 */
+ (NEHTTPModelManager *)defaultManager;

/**
 *  create NEHTTPModel table
 */
- (void)createTable;


/**
 *  add a NEHTTPModel object to SQLite
 *
 *  @param aModel a NEHTTPModel object
 */
- (void)addModel:(NEHTTPModel *) aModel;

/**
 *  get SQLite all NEHTTPModel object
 *
 *  @return all NEHTTPModel object
 */
- (NSMutableArray *)allobjects;

/**
 *  delete all SQLite records
 */
- (void) deleteAllItem;

@end
