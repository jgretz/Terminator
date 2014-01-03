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

@end
