//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@interface FaceCapture : NSObject

@property (strong) UIImage* faceImage;

@property CGPoint leftEyePosition;
@property CGPoint rightEyePosition;
@property CGPoint mouthPosition;

@end