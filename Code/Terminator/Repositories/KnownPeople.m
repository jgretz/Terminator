//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "KnownPeople.h"
#import "Person.h"
#import "JsonCerealizer.h"

@interface KnownPeople()

@property (strong) NSMutableDictionary* people;
@property (strong) JsonCerealizer* cerealizer;

@end

@implementation KnownPeople

#pragma mark - Load / Save
-(NSString*) fileName {
    return [Path subLibraryCachesDirectory: @"people.json"];
}

-(void) loadFromDisk {
    NSString* json = [NSString stringWithContentsOfFile: self.fileName encoding: NSUTF8StringEncoding error: nil];
    NSArray* stored = json ? [self.cerealizer createArrayOfType: [Person class] fromString: json] : @[ ];

    @synchronized (self) {
        self.people = [NSMutableDictionary dictionary];
        for (Person* person in stored)
            self.people[[NSNumber numberWithInt: person.id]] = person;
    }
}

-(void) save {
    NSString* json = [self.cerealizer toString: self.allPeople];
    [json writeToFile: self.fileName atomically: NO encoding: NSUTF8StringEncoding error: nil];
}

#pragma mark - Mgmt
-(NSArray*) allPeople {
    return self.people.allValues;
}

-(void) addPerson: (Person*) person {
    @synchronized (self) {
        self.people[[NSNumber numberWithInt: person.id]] = person;
    }
}

-(Person*) getPerson: (int) id {
    return self.people[[NSNumber numberWithInt: id]];
}

@end