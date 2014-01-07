//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ImageCapture : NSObject

@property (strong) CIImage* image;
@property (strong) NSDate* captured;

@property (readonly) UIImage* uiImage;


@end