//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import "ContainerConfiguration.h"
#import "Terminator.h"
#import "SquareCam.h"
#import "LightSensor.h"

@implementation ContainerConfiguration

+(void) configure {
    [Terminator registerClassAndCache: YES];
    [SquareCam registerClassAndCache: YES];
    [LightSensor registerClassAndCache: YES];
}

@end