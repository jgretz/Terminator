//
//  Terminator.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "Terminator.h"
#import "Memory.h"
#import "Brain.h"
#import "Eyes.h"
#import "Person.h"

@interface Terminator()

@property (strong) Memory* memory;
@property (strong) Brain* brain;
@property (strong) Eyes* eyes;

@end

@implementation Terminator

-(void) startup {
    [self.memory startup];
    [self.brain startup];
    [self.eyes startup];
}

-(void) shutdown {
    [self.eyes shutdown];
    [self.brain shutdown];
    [self.memory shutdown];
}

-(void) rememberPersonNamed: (NSString*) name withImages: (NSArray*) images {
    [self.memory addPersonNamed: name withImages: images];
}

-(void) rememberAdditionalImages: (NSArray*) images forPerson: (Person*) person {
    [self.memory addImages: images toPerson: person];
}


@end
