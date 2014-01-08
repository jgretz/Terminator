//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "CameraRoll.h"
#import "OPSCounter.h"

@interface CameraRoll()

@property (strong) OPSCounter* opsCounter;

@end

@implementation CameraRoll

-(float) framesPerSecond {
    return self.opsCounter.ops;
}

-(void) pushImage: (CIImage*) image {
    @synchronized (self) {
        [self.opsCounter addOperationAt: [NSDate date]];

        [[NSNotificationCenter defaultCenter] postNotificationName: [Constants ImageAddedToCameraRoll] object: image];
    }
}

@end