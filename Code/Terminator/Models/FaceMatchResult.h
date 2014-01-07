//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>


@interface FaceMatchResult : NSObject

@property (copy) NSNumber* personID;
@property (copy) NSString* personName;
@property (copy) NSString* confidence;
@property (readonly) float confidenceDecimal;

@end