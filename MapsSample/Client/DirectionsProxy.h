//
//  DirectionsProxy.h
//  MapsSample
//
//  Created by NS on 3/2/16.
//  Copyright © 2016 Sinhngn. All rights reserved.
//

#import "BaseProxy.h"


@interface DirectionsProxy : BaseProxy

- (void)getDirection:(NSString *)star
         destination:(NSString *)end
           completed:(DidGetResultBlock)complete
               error:(DidGetResultBlock)errHandler;

@end
