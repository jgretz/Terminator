//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "NamelessMasses.h"
#import "NamelessPerson.h"
#import "PostOffice.h"

@interface NamelessMasses()

@property (strong) NSMutableArray* masses;
@property (strong) PostOffice* postOffice;

@end


@implementation NamelessMasses

-(id) init {
    if ((self = [super init])) {
        self.masses = [NSMutableArray array];
    }

    return self;
}

-(NSArray*) people {
    @synchronized (self) {
        return [NSArray arrayWithArray: self.masses];
    }
}


-(void) addPerson: (NamelessPerson*) person {
    @synchronized (self) {
        [self.masses addObject: person];

        [self.postOffice postMessage: [Constants NamelessPersonFound] paylod: person];
    }
}

-(void) removePeople: (NSArray*) peopleToRemove {
    @synchronized (self) {
        [self.masses removeObjectsInArray: peopleToRemove];
    }
}


-(void) clear {
    @synchronized (self) {
        [self.masses removeAllObjects];
    }

}
@end