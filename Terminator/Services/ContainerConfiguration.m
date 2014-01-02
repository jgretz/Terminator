//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import "ContainerConfiguration.h"
#import "Terminator.h"
#import "SquareCam.h"
#import "CameraRoll.h"
#import "FaceDetector.h"
#import "FaceLibrary.h"

@implementation ContainerConfiguration

+(void) configure {
    [CameraRoll registerClassAndCache: YES];
    [SquareCam registerClassAndCache: YES];

    [FaceLibrary registerClassAndCache: YES];

    [Terminator registerClass];
    [FaceDetector registerClass];
}

@end