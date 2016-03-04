//
//  DirectionsProxy.m
//  MapsSample
//
//  Created by NS on 3/2/16.
//  Copyright © 2016 Sinhngn. All rights reserved.
//

#import "DirectionsProxy.h"

#define STRING(karg,...)  [NSString stringWithFormat:(karg),##__VA_ARGS__]

@implementation DirectionsProxy

/*! POST User Login, item is a LoginUser Model class
 * @param completed is a Handler
 */
- (void)getDirection:(NSString *)star destination:(NSString *)end key:(NSString *)key
           completed:(DidGetResultBlock)complete error:(DidGetResultBlock)errHandler {
//http://maps.googleapis.com/maps/api/directions/json?origin=10.7514429,106.7054975&destination=10.7589823,106.6965149&sensor=false
    BaseOperation * callOp = [[BaseOperation alloc] init];
    NSString *urlStr = STRING(@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=false",star,end);
    NSString *encodedUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedUrl];
  
    callOp.request = [NSMutableURLRequest requestWithURL:url];
    
    [(NSMutableURLRequest*)callOp.request setHTTPMethod:@"GET"];
    [(NSMutableURLRequest*)callOp.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    callOp.completionHandler = ^(NSData *result, NSURLResponse *res) {
        [self finishGetDirection:result res:res  completed:complete error:errHandler];
    };
    
    callOp.errorHandler = ^(NSError *err) {
        errHandler(err, ERROR_LOCAL, @"");
    };
    
    [callOp start];
}

- (void)finishGetDirection:(NSData *)result res:(NSURLResponse *)res
              completed:(DidGetResultBlock)handler error:(DidGetResultBlock)errHandler
{
    NSInteger httpCode = [(NSHTTPURLResponse*)res statusCode];
    
    if(httpCode != 200) {
        NSDictionary *jsonDict = [self.parser objectWithData:result];
        [self errorParse:errHandler dictionary:jsonDict];
        return;
    }
    
    NSDictionary *jsonDict = [self.parser objectWithData:result];
    NSArray *router = [jsonDict objectForKey:@"routes"];
    NSDictionary *dict = [router objectAtIndex:0];
    NSDictionary *overview_polyline = [dict objectForKey:@"overview_polyline"];
    NSString *str = [overview_polyline objectForKey:@"points"];
    
    handler(str,@"", @"");

}

@end
