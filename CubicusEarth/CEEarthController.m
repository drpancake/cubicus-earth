//
//  CEEarthController.m
//  CubicusEarth
//
//  Created by James Potter on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CEEarthController.h"
#import "CubicusEarth.h"

@implementation CEEarthController

@synthesize client;
@synthesize earthViewController;

- (id)initWithClient:(CBAppClient *)theClient
{
    self = [super initWithWindowNibName:NSStringFromClass([self class])];
    if (self) {
        client = theClient;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    earthViewController = [[JPEarthViewController alloc] init];
    self.window.contentView = self.earthViewController.view;
    
    [self createCubicusContext];
}

- (void)createCubicusContext
{
    // Zoom buttons in a vertical container
    
    CBButton *zoomIn = [[CBButton alloc] init];
    zoomIn.elementID = CEEarthControllerElementZoomIn;
    zoomIn.ratio = 0.5;
    zoomIn.label = @"Forward";
    
    CBButton *zoomOut = [[CBButton alloc] init];
    zoomOut.elementID = CEEarthControllerElementZoomOut;
    zoomOut.ratio = 0.5;
    zoomOut.label = @"Back";
    
    CBVerticalBox *zoomBox = [[CBVerticalBox alloc] init];
    zoomBox.elementID = CEEarthControllerElementZoomBox;
    zoomBox.ratio = 0.25; // 25% of entire screen width
    zoomBox.items = [NSArray arrayWithObjects:zoomIn, zoomOut, nil];
    
    // Accelerator
    
    CBAccelerator *accelerator = [[CBAccelerator alloc] init];
    accelerator.elementID = CEEarthControllerElementAccelerator;
    accelerator.ratio = 0.75; // 75% of entire screen width
    
    // Root container
    
    CBHorizontalBox *rootBox = [[CBHorizontalBox alloc] init];
    rootBox.elementID = CEEarthControllerElementRoot;
    rootBox.ratio = 1;
    rootBox.items = [NSArray arrayWithObjects:zoomBox, accelerator, nil];
    
    // Context model
    CBLayout *layout = [[CBLayout alloc] initWithRoot:rootBox];
    CBContext *context = [[CBContext alloc] initWithID:CE_EARTH_CONTEXT layout:layout];
    
    // Create context manager and register it
    CBContextManager *manager = [[CBContextManager alloc] initWithContext:context];
    manager.delegate = self;
    //    [manager wrapView:self.view];
    [client addContextManager:manager defaultContext:YES];
}

#pragma mark -
#pragma mark CBContextManagerDelegate

- (void)manager:(CBContextManager *)manager didReceiveEvent:(CBEvent *)event
{
    if (event.elementID == CEEarthControllerElementAccelerator) {
        NSDictionary *content = event.content;
        
        // TODO: clients should normalise acceleration values before transmitting them
        // (but they're probably already 0-1 ratios anyway)
        int multiplier = 150;
        
        [self.earthViewController panX:[[content objectForKey:@"x"] doubleValue] * multiplier
                                     y:[[content objectForKey:@"y"] doubleValue] * multiplier];
    } else if (event.elementID == CEEarthControllerElementZoomIn) {
        [self.earthViewController zoomIn];
    } else if (event.elementID == CEEarthControllerElementZoomOut) {
        [self.earthViewController zoomOut];
    }
}

@end
