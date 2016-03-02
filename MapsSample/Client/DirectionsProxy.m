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

    BaseOperation * callOp = [[BaseOperation alloc] init];
    NSString *urlStr = STRING(@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&key=%@",star,end,key);
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
    
    //NSDictionary *jsonDict = [self.parser objectWithData:result];

}

@end
