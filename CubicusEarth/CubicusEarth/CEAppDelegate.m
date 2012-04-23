//
//  CEAppDelegate.m
//  CubicusEarth
//
//  Created by James Potter on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CEAppDelegate.h"

@implementation CEAppDelegate

@synthesize earthController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.earthController = [[CEEarthController alloc] init];
    [self.earthController showWindow:nil];
    [self.earthController.window setContentSize:NSMakeSize(800, 600)];
}

@end
