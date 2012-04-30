//
//  CEEarthController.h
//  CubicusEarth
//
//  Created by James Potter on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JPEarthViewController.h"
#import "CBShared.h"

enum {
    CEEarthControllerElementRoot = 1,
    CEEarthControllerElementZoomBox,
    CEEarthControllerElementZoomIn,
    CEEarthControllerElementZoomOut,
    CEEarthControllerElementAccelerator
} CEEarthControllerElement;

@interface CEEarthController : NSWindowController <CBContextManagerDelegate>

- (id)initWithClient:(CBAppClient *)client;

// Create context manager
- (void)createCubicusContext;

@property (nonatomic, strong, readonly) CBAppClient *client;
@property (nonatomic, strong, readonly) JPEarthViewController *earthViewController;

@end