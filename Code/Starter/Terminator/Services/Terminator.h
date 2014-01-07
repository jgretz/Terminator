//
//  Terminator.h
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TerminatorBase.h"

@class Person;

@interface Terminator : TerminatorBase

-(void) startup;
-(void) shutdown;

-(void) rememberPersonNamed: (NSString*) name withImages: (NSArray*) images;
-(void) rememberAdditionalImages: (NSArray*) images forPerson: (Person*) person;

@end
