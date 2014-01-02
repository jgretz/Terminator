//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class FaceCapture;

@interface FaceIdentifier : NSObject

-(void) identifyFace: (FaceCapture*) faceCapture;

@end