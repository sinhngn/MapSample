//
//  FilmOnline
//
//  Created by NS on 3/30/15.
//  Copyright (c) 2015 Sinhngn. All rights reserved.
//

#import "BaseProxy.h"

@implementation BaseProxy

@synthesize parser, writer;//, errorHandler;

- (id)init
{
    self = [super init];
    if (self) {
        parser = [[SBJsonParser alloc] init];
        writer = [[SBJsonWriter alloc] init];
        writer.humanReadable = YES;
        writer.sortKeys = YES;
    }
    return self;
}

#pragma mark support function
- (BOOL)isNumber:(NSString *)str {
    NSScanner *scanner = [NSScanner scannerWithString:str];
    return [scanner scanInteger:NULL] && [scanner isAtEnd];
}

- (void)errorParse:(DidGetResultBlock)errHandler dictionary:(NSDictionary *)jsonDict {
    
}

@end
