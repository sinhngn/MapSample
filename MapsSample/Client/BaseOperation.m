//
//  FilmOnline
//
//  Created by NS on 3/30/15.
//  Copyright (c) 2015 Sinhngn. All rights reserved.
//

#import "BaseOperation.h"

@implementation BaseOperation

@synthesize errorHandler;
@synthesize completionHandler;
@synthesize conn;
@synthesize result;
@synthesize uri;
@synthesize request;
@synthesize response;


#pragma mark - request

- (void)start {
    if (!self.request) return;
    self.result = [NSMutableData data];
    // alloc+init and start an NSURLConnection; release on completion/failure
    NSURLConnection *theConn = [[NSURLConnection alloc] initWithRequest:
                             self.request delegate:self];
    self.conn = theConn;
}

- (void)cancel
{
    [self.conn cancel];
    self.conn = nil;
    self.result = nil;
}

#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)theResponse
{
    self.response = theResponse;
    self.result = [NSMutableData data];    // start off with new data
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.result appendData:data];  // append incoming data
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.errorHandler(error);
    self.conn = nil;   // release our connection
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.conn = nil;   // release our connection
    self.completionHandler(self.result, self.response);
    self.result = nil;
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSArray * trustedHosts = [NSArray arrayWithObjects:@"*google.com",nil];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
