//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@interface FaceCapture : NSObject

@property (strong) NSDate* captured;
@property (strong) UIImage* faceImage;

@end