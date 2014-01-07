//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "CameraRoll.h"
#import "ImageCapture.h"
#import "OPSCounter.h"

@interface CameraRoll()

@property (strong) OPSCounter* opsCounter;

@end

@implementation CameraRoll

-(id) init {
    if ((self = [super init])) {
        self.capturedImages = [NSMutableArray array];
    }

    return self;
}

-(float) framesPerSecond {
    return self.opsCounter.ops;
}

-(void) pushImage: (ImageCapture*) capture {
    @synchronized (self) {
        [self.capturedImages addObject: capture];

        [[NSNotificationCenter defaultCenter] postNotificationName: [Constants ImageAddedToCameraRoll] object: capture.uiImage];
    }

    [self.opsCounter addOperationAt: [NSDate date]];
}

-(NSArray*) pop {
    @synchronized (self) {
        NSArray* images = [NSArray arrayWithArray: self.capturedImages];
        [self.capturedImages removeAllObjects];

        return images;
    }
}

@end