//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class Person;

@interface Memory : NSObject

-(void) startup;
-(void) shutdown;

-(void) addPersonNamed: (NSString*) name withImages: (NSArray*) images;
-(void) addImages: (NSArray*) images toPerson: (Person*) person;

@end