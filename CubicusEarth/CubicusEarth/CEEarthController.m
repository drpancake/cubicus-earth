//
//  CEEarthController.m
//  CubicusEarth
//
//  Created by James Potter on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CEEarthController.h"

@implementation CEEarthController

@synthesize earthViewController;

- (id)init
{
    self = [super initWithWindowNibName:NSStringFromClass([self class])];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    earthViewController = [[JPEarthViewController alloc] init];
    self.window.contentView = self.earthViewController.view;
}

@end
