//
//  CEAppDelegate.h
//  CubicusEarth
//
//  Created by James Potter on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CEEarthController.h"
#import "CBShared.h"

@interface CEAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) CEEarthController *earthController;
@property (nonatomic, strong) CBAppClient *client;

@end
