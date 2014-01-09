//
// Created by Joshua Gretz on 1/5/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "TerminatorBase.h"


@implementation TerminatorBase

-(void) speak: (NSString*) message {
    [[NSNotificationCenter defaultCenter] postNotificationName: [Constants TerminatorMessage] object: message];
}

@end