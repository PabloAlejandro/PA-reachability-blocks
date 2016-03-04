//
//  ViewController.m
//  ReachabilityBlocks
//
//  Created by Pau on 04/03/2016.
//  Copyright © 2016 Pablo Alejandro. All rights reserved.
//

#import "ViewController.h"
#import "ReachabilityBlocks.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, strong) ReachabilityBlocks * reachabilityBlocks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self startReachabilityListener];
}

#pragma mark - Reachability

- (void)startReachabilityListener
{
    [self.reachabilityBlocks listenReachabilityUpdates:^(GCNetworkReachabilityStatus networkStatus) {
        
        switch (networkStatus) {
            case GCNetworkReachabilityStatusWiFi:
                self.label.text = @"WiFi";
                break;
            case GCNetworkReachabilityStatusWWAN:
                self.label.text = @"WWAN";
                break;
            case GCNetworkReachabilityStatusNotReachable:
                self.label.text = @"Not Reachable";
                break;
        }
    }];
}

#pragma mark - Getters

- (ReachabilityBlocks *)reachabilityBlocks
{
    if(_reachabilityBlocks == nil) {
        _reachabilityBlocks = [ReachabilityBlocks new];
    }
    return _reachabilityBlocks;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
