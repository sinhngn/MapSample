//
//  FilmOnline
//
//  Created by NS on 3/30/15.
//  Copyright (c) 2015 Sinhngn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishBlock)(NSData *result, NSURLResponse *response);
typedef void (^ErrorBlock)(NSError *error);

@interface BaseOperation : NSObject
{
    NSString *uri;
    NSURLConnection *conn;
    NSURLRequest *request;
    NSURLResponse *response;
    NSMutableData *result;
    ErrorBlock errorHandler;
    FinishBlock completionHandler;
}

@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSMutableData *result;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, retain) NSURLResponse *response;
@property (nonatomic, retain) NSURLConnection *conn;
@property (nonatomic, copy) ErrorBlock errorHandler;
@property (nonatomic, copy) FinishBlock completionHandler;

- (void)start;
- (void)cancel;

@end
