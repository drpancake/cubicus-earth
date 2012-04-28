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
    // Accelerator
    CBAccelerator *accelerator = [[CBAccelerator alloc] init];
    accelerator.elementID = 1;
    accelerator.ratio = 1;
    
    // Container
    CBHorizontalBox *box = [[CBHorizontalBox alloc] init];
    box.elementID = 2;
    box.ratio = 1;
    box.items = [NSArray arrayWithObject:accelerator];
    
    // Context model
    CBLayout *layout = [[CBLayout alloc] initWithRoot:box];
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
    if (event.elementID == 1) {
        NSDictionary *content = event.content;
        
        // TODO: clients should normalise acceleration values before transmitting them
        // (but they're probably already 0-1 ratios anyway)
        int multiplier = 150;
        
        [self.earthViewController panX:[[content objectForKey:@"x"] doubleValue] * multiplier
                                     y:[[content objectForKey:@"y"] doubleValue] * multiplier];
    }
}

@end
