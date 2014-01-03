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

const NSString* JSON = @"json";

-(id) init {
    if ((self = [super init])) {
        self.client = [MSClient clientWithApplicationURLString: @"https://terminator.azure-mobile.net/" applicationKey: @"zBUQxxKAdkcKyfXSMkABHfrSKtBHFU51"];
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
        for (NSDictionary* dict in items)
            [people addObject: [self.cerealizer create: [Person class] fromString: dict[JSON]]];

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
            [self.peopleTable insert: @{ @"json" : json } completion: ^(NSDictionary* insertedItem, NSError* error) {
                if (error) {
                    [self handleError: error];
                    return;
                }

                person.azureId = insertedItem[@"id"];
            }];

        }
    }];
}

-(void) handleError: (NSError*) error {
    NSLog(@"Error: %@", error);
}

@end