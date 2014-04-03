//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.

#import "FaceDetection.h"
#import "OPSCounter.h"
#import "PostOffice.h"

@interface FaceDetection()

@property (strong) OPSCounter* ipsCounter;
@property (strong) PostOffice* postOffice;

@end

@implementation FaceDetection

-(float) imagesProcessedPerSecond {
    return self.ipsCounter.ops;
}

-(void) detectFaces: (CIImage*) image {

}

@end