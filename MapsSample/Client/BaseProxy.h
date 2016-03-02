//
//  FilmOnline
//
//  Created by NS on 3/30/15.
//  Copyright (c) 2015 Sinhngn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBjsonHelper/SBJson.h"
#import "BaseOperation.h"

#define HTTPDOMAIN @"HTTPDOMAIN"
#define ERROR_LOCAL @"ERROR_LOCAL"
#define ERROR_PARSER @"ERROR_PARSER"

typedef void (^DidGetItemsBlock)(NSArray *result, NSString *errorCode, NSString *message);
typedef void (^DidGetResultBlock)(id result, NSString *errorCode, NSString *message);

//! set Navitaion title
typedef void (^DidGetMessageBlock)(id data, NSString *name_error, NSString *errorCode, NSString *message);


@class SBJsonParser;
@class SBJsonWriter;

@interface BaseProxy : NSObject
{
    SBJsonParser *parser;
    SBJsonWriter *writer;
}

@property (nonatomic, retain) SBJsonParser *parser;
@property (nonatomic, retain) SBJsonWriter *writer;

- (void)errorParse:(DidGetResultBlock)errHandler dictionary:(NSDictionary *)jsonDict;
@end
