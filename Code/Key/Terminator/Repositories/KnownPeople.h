//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class Person;

@interface KnownPeople : NSObject

-(void) loadFromDisk;
-(void) save;

-(NSArray*) allPeople;

-(void) addPerson: (Person*) person;
-(Person*) getPerson: (int) id;

@end