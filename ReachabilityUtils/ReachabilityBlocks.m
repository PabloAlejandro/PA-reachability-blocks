//
//  ReachabilityBlocks.h
//  PA-reachability-blocks
//
//  Created by Pau on 04/03/2016.
//  Copyright © 2016 Pablo Alejandro. All rights reserved.
//

#import "ReachabilityBlocks.h"
#import <UIKit/UIKit.h>

@interface ReachabilityBlocks ()

@property (retain, nonatomic)  GCNetworkReachability *reachability;
@property (nonatomic, copy) void(^  __nullable reachabilityBlock)(GCNetworkReachabilityStatus remoteHostStatus);

@end

@implementation ReachabilityBlocks

- (instancetype)init
{
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

#pragma mark - Private class methods

- (void)setup
{
    self.reachability = [GCNetworkReachability reachabilityForInternetConnection];
    [self.reachability startMonitoringNetworkReachabilityWithNotification];
    
    [self registerForNotifications];
}

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityUpdated:)
                                                 name:kGCNetworkReachabilityDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityUpdated:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)reachabilityUpdated:(NSNotification *)notice
{
    GCNetworkReachabilityStatus remoteHostStatus = [[GCNetworkReachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.reachabilityBlock(remoteHostStatus);
    });
}

#pragma mark - Public class methods

- (void)listenReachabilityUpdates:(void(^ __nullable)(GCNetworkReachabilityStatus networkStatus))completion
{
    self.reachabilityBlock = completion;
}

@end
