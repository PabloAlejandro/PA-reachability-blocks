//
//  ReachabilityBlocks.h
//  PA-reachability-blocks
//
//  Created by Pau on 04/03/2016.
//  Copyright © 2016 Pablo Alejandro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCNetworkReachability.h"
//#import "Reachability+Status.h"

@interface ReachabilityBlocks : NSObject

/**
 * Completion block is called when there is a change on reachability
 */
- (void)listenReachabilityUpdates:(void(^)(GCNetworkReachabilityStatus networkStatus))completion;

@end
