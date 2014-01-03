//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class Person;
@class FaceMatchResult;

@interface OpenCVFaceRecognition : NSObject

-(void) train;

-(void) learnFace: (UIImage*) image forPerson: (Person*) person;

-(FaceMatchResult*) searchForFace: (UIImage*) image;

@end