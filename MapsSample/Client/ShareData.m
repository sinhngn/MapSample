//
//  FilmOnline
//
//  Created by NS on 3/30/15.
//  Copyright (c) 2015 Sinhngn. All rights reserved.
//

#import "ShareData.h"

@implementation ShareData
@synthesize directionsProxy;

static ShareData *_instance = nil;

- (id)init
{
    self = [super init];
    if (self) {
      
        directionsProxy = [[DirectionsProxy alloc] init];
    
    }
    
    return self;
}

+ (ShareData *)instance {
    @synchronized(self){
        if(_instance == nil){
            _instance= [ShareData new];
        }
    }
    
    return _instance;
}

@end
