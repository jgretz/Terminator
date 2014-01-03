//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import "ContainerConfiguration.h"
#import "Terminator.h"
#import "SquareCam.h"
#import "CameraRoll.h"
#import "FaceDetection.h"
#import "FaceIdentifier.h"
#import "JsonCerealizer.h"
#import "NamelessMasses.h"

@implementation ContainerConfiguration

+(void) configure {
    [CameraRoll registerClassAndCache: YES];
    [SquareCam registerClassAndCache: YES];

    [FaceIdentifier registerClassAndCache: YES];

    [NamelessMasses registerClassAndCache: YES];

    [Terminator registerClass];
    [FaceDetection registerClass];

    [JsonCerealizer registerClass];
}

@end