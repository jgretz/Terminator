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
#import "Body.h"

@interface Terminator()

@property (strong) Memory* memory;
@property (strong) Brain* brain;
@property (strong) Eyes* eyes;
@property (strong) Body* body;

@end

@implementation Terminator

-(void) startup {
    [self speak: @"Booting Memory ..."];
    [self.memory startup];

    [self speak: @"Booting Brain ..."];
    [self.brain startup];

    [self speak: @"Booting Eyes ..."];
    [self.eyes startup];

    [self speak: @"Booting Body ..."];
    [self.body startup];
}

-(void) shutdown {
    [self.eyes shutdown];
    [self.brain shutdown];
    [self.memory shutdown];

    [self.body shutdown];
}

-(void) rememberPersonNamed: (NSString*) name withImages: (NSArray*) images {
    [self.memory addPersonNamed: name withImages: images];
}

-(void) rememberAdditionalImages: (NSArray*) images forPerson: (Person*) person {
    [self.memory addImages: images toPerson: person];
}

@end
