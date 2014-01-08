//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class NamelessPerson;

@interface NamelessMasses : NSObject

@property (readonly) NSArray* people;

-(void) addPerson: (NamelessPerson*) person;
-(void) removePeople: (NSArray*) peopleToRemove;

@end