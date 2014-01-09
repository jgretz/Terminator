//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "CameraRoll.h"
#import "OPSCounter.h"
#import "PostOffice.h"

@interface CameraRoll()

@property (strong) OPSCounter* opsCounter;
@property (strong) PostOffice* postOffice;

@end

@implementation CameraRoll

-(float) framesPerSecond {
    return self.opsCounter.ops;
}

-(void) pushImage: (CIImage*) image {
    NSDate* date = [NSDate date];

    [self.postOffice postMessage: [Constants ImageAddedToCameraRoll] paylod: @{ [Constants Image] : image, [Constants Timestamp] : [NSDate date] }];
    [self.opsCounter addOperationAt: date];
}

@end