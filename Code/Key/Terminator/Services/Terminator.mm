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
    [self speak: @"Shutting Down Eyes ..."];
    [self.eyes shutdown];
    
    [self speak: @"Shutting Down Brain ..."];
    [self.brain shutdown];
    
    [self speak: @"Shutting Down Memory ..."];
    [self.memory shutdown];
    
    [self speak: @"Shutting Down Body ..."];
    [self.body shutdown];
}

#pragma mark - Memory Control
-(void) rememberPersonNamed: (NSString*) name withImages: (NSArray*) images {
    [self.memory addPersonNamed: name withImages: images];
}

-(void) rememberAdditionalImages: (NSArray*) images forPerson: (Person*) person {
    [self.memory addImages: images toPerson: person];
}

#pragma mark - Movement Control

-(void) turnRight {
    [self.body turnRight];
}

-(void) turnLeft {
    [self.body turnLeft];
}

-(void) goForward {
    [self.body goForward];
}

-(void) goBackward {
    [self.body goBackward];
}

-(void) tiltForward {
    [self.body tiltForward];
}

-(void) tiltBackward {
    [self.body tiltBackward];
}

-(void) stopTilt {
    [self.body stopTilt];
}

-(void) toggleLED {
    [self.body toggleLED];
}


@end
