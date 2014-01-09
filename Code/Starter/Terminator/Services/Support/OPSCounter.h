//
// Created by Joshua Gretz on 1/7/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>


@interface OPSCounter : NSObject

@property (nonatomic) float ops;

-(void) addOperationAt: (NSDate*) time;

@end