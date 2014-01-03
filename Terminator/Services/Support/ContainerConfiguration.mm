//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import "ContainerConfiguration.h"
#import "Terminator.h"
#import "SquareCam.h"
#import "CameraRoll.h"
#import "FaceDetection.h"
#import "OpenCVFaceRecognition.h"
#import "JsonCerealizer.h"
#import "NamelessMasses.h"
#import "KnownPeople.h"
#import "Memory.h"
#import "Brain.h"
#import "Eyes.h"

@implementation ContainerConfiguration

+(void) configure {
    [CameraRoll registerClassAndCache: YES];
    [SquareCam registerClassAndCache: YES];

    [OpenCVFaceRecognition registerClassAndCache: YES];

    [KnownPeople registerClassAndCache: YES];
    [NamelessMasses registerClassAndCache: YES];

    [Terminator registerClass];
    [Memory registerClass];
    [Brain registerClass];
    [Eyes registerClass];

    [FaceDetection registerClass];

    [JsonCerealizer registerClass];
}

@end