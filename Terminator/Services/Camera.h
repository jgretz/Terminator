//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import <Foundation/Foundation.h>


@interface Camera : NSObject

@property (copy) void(^onCaptureImage)(UIImage*);

-(void) startCapturing;
-(void) stopCapturing;

@end