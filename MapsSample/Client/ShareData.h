//
//  FilmOnline
//
//  Created by NS on 3/30/15.
//  Copyright (c) 2015 Sinhngn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionsProxy.h"

@interface ShareData : NSObject

@property(nonatomic,retain) DirectionsProxy *directionsProxy;

+ (ShareData *)instance;

@end
