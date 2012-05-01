//
//  CEAppDelegate.m
//  CubicusEarth
//
//  Created by James Potter on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CEAppDelegate.h"
#import "CubicusEarth.h"

@implementation CEAppDelegate

@synthesize earthController;
@synthesize client;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Create a client but don't connect yet
    CBHost *host = [[CBHost alloc] initWithAddress:CE_DAEMON_HOST port:[NSNumber numberWithInt:CE_DAEMON_PORT]];
    self.client = [[CBAppClient alloc] initWithHost:host applicationName:CE_APP_NAME];
    
    self.earthController = [[CEEarthController alloc] initWithClient:self.client];
    [self.earthController showWindow:nil];
    [self.earthController.window setContentSize:NSMakeSize(800, 600)];
    
    // By this point controllers have provided client with a set of
    // CBContextManager objects ready to send to daemon on connecting
    [self.client connect];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    if (self.client.connected)
        [self.client sendBecameActive];
}

@end
