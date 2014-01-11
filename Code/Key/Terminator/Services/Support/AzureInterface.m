//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "AzureInterface.h"
#import "Person.h"
#import "Cerealizer.h"
#import "JsonCerealizer.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface AzureInterface()

@property (strong) MSClient* client;
@property (strong) JsonCerealizer* cerealizer;

@end

@implementation AzureInterface

const NSString* ID = @"id";
const NSString* JSON = @"json";

-(id) init {
    if ((self = [super init])) {
        self.client = [MSClient clientWithApplicationURLString: @"<Insert App Url>" applicationKey: @"<Insert App Key>"];
    }
    return self;
}

#pragma mark - People
-(MSTable*) peopleTable {
    return [self.client tableWithName: @"People"];
}

-(void) downloadPeopleFromAzure: (void (^)(NSArray*)) parsePeople {
    [self.peopleTable readWithCompletion: ^(NSArray* items, NSInteger totalCount, NSError* error) {
        if (error) {
            [self handleError: error];
            return;
        }

        NSMutableArray* people = [NSMutableArray array];
        for (NSDictionary* dict in items) {
            Person* person = [self.cerealizer create: [Person class] fromString: dict[JSON]];
            if (!person.azureId)
                person.azureId = dict[ID];
            [people addObject: person];
        }

        parsePeople(people);
    }];
}

-(void) writePersonToAzure: (Person*) person {
    NSString* id = person.azureId;
    NSString* json = [self.cerealizer toString: person];

    [self.peopleTable readWithId: id completion: ^(NSDictionary* item, NSError* error) {
        if (item) {
            NSMutableDictionary* mutable = item.mutableCopy;
            mutable[JSON] = json;

            [self.peopleTable update: mutable completion: ^(NSDictionary* item, NSError* error) {
                if (error) {
                    [self handleError: error];
                    return;
                }
            }];
        }
        else {
            [self.peopleTable insert: @{ JSON : json } completion: ^(NSDictionary* insertedItem, NSError* error) {
                if (error) {
                    [self handleError: error];
                    return;
                }

                person.azureId = insertedItem[ID];
            }];

        }
    }];
}

-(void) handleError: (NSError*) error {
    NSLog(@"Error: %@", error);
}

@end