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


// AzureSetup

-(void) downloadPeopleFromAzure: (void (^)(NSArray*)) parsePeople {
    // AzureRead
}

-(void) writePersonToAzure: (Person*) person {
    // AzureWrite
}

-(void) handleError: (NSError*) error {
    NSLog(@"Error: %@", error);
}

@end