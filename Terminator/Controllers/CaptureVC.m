//
//  MainVC.m
//  Terminator
//
//  Created by Joshua Gretz on 11/29/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "CaptureVC.h"
#import "SquareCam.h"

@interface CaptureVC()

@end

@implementation CaptureVC

-(id) init {
    if ((self = [super init])) {
        self.title = @"Capture";
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    SquareCam* camera = [SquareCam object];
    [camera useCamera:  AVCaptureDevicePositionFront];
    [camera addObserver: self forKeyPath: OBJECT_KEYPATH(camera, mostRecentImage) options: NSKeyValueObservingOptionNew context: nil];
}

-(void) observeValueForKeyPath: (NSString*) keyPath ofObject: (id) object change: (NSDictionary*) change context: (void*) context {
    [self performBlockInMainThread: ^{
        self.currentView.image = [[SquareCam object] mostRecentImage];
    }];
}

@end
