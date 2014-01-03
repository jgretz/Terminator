//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "NamelessMasses.h"
#import "FaceCapture.h"

@interface NamelessMasses()

@property (strong) NSMutableArray* masses;

@end


@implementation NamelessMasses

-(id) init {
    if ((self = [super init])) {
        self.masses = [NSMutableArray array];
    }

    return self;
}

-(NSArray*) faces {
    @synchronized (self) {
        return [NSArray arrayWithArray: self.masses];
    }
}


-(void) addFace: (FaceCapture*) face {
    @synchronized (self) {
        [self.masses addObject: face];
    }
}

@end