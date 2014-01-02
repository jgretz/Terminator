//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class FaceCapture;

typedef void(^FaceNotification)(FaceCapture*);

@interface FaceLibrary : NSObject

@property (strong) NSMutableArray* faces;

-(void) addFaceToLibrary: (FaceCapture*) faceCapture;

-(void) registerForNewFaceNotification: (FaceNotification) faceNotification;

@end