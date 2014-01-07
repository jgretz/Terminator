//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

@class Person;

@interface AzureInterface : NSObject

-(void) downloadPeopleFromAzure: (void (^)(NSArray*)) parsePeople;
-(void) writePersonToAzure: (Person*) person;

@end