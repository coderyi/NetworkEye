//
//  NESqliteDataReader.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NESqliteDataReader.h"

@implementation NESqliteDataReader

- (id)initWithStatement:(sqlite3_stmt *)aStatement{
    self=[super init];
    if (self) {
        statement=aStatement;
    }
    return self;
}

- (BOOL)read{
    return sqlite3_step(statement)==SQLITE_ROW;
}

- (int)integerValueForColumnIndex:(NSUInteger)columnIndex{
    int value=sqlite3_column_int(statement, (int)columnIndex);
    return value;
}

- (double)doubleValueForColumnIndex:(NSUInteger)columnIndex{
    double value=sqlite3_column_double(statement, (int)columnIndex);
    return value;
}

- (NSString *)stringValueForColumnIndex:(NSUInteger)columnIndex{
    const unsigned char *value=sqlite3_column_text(statement, (int)columnIndex);
    return [NSString stringWithCString:(const char *)value encoding:NSUTF8StringEncoding];
}

- (void)close{
    sqlite3_finalize(statement);
}


@end
