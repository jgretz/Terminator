//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.

#import <Foundation/Foundation.h>

@interface CameraRoll : NSObject

@property (readonly) float framesPerSecond;

-(void) pushImage: (CIImage*) image;

@end