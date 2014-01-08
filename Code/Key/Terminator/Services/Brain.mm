//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "Brain.h"
#import "FaceDetection.h"
#import "FaceMatchResult.h"
#import "OpenCVFaceRecognition.h"
#import "NamelessMasses.h"
#import "KnownPeople.h"
#import "Person.h"
#import "NamelessPerson.h"

@interface Brain()

@property (strong) FaceDetection* faceDetection;
@property (strong) OpenCVFaceRecognition* faceRecognition;

@property (strong) NSOperationQueue* detectFacesQueue;
@property (strong) NSOperationQueue* searchForPeopleQueue;

@property (nonatomic) BOOL running;

@end

@implementation Brain

-(void) startup {
    self.running = YES;

    self.detectFacesQueue = [[NSOperationQueue alloc] init];
    self.detectFacesQueue.maxConcurrentOperationCount = 2;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(imageAddedToCameraRoll:) name: [Constants ImageAddedToCameraRoll] object: nil];

    self.searchForPeopleQueue = [[NSOperationQueue alloc] init];
    self.searchForPeopleQueue.maxConcurrentOperationCount = 2;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(facesFoundInImage:) name: [Constants FacesFoundInImage] object: nil];
}

-(void) shutdown {
    self.running = NO;
}

#pragma mark - Detect Faces From Images Seen
-(void) imageAddedToCameraRoll: (NSNotification*) notification {
    if (!self.running)
        return;

    [self.detectFacesQueue addOperationWithBlock: ^{
        [self.faceDetection detectFaces: notification.object];
    }];
}

#pragma mark - Search Faces For Known People
-(void) facesFoundInImage: (NSNotification*) notification {
    if (!self.running)
        return;

    [self.searchForPeopleQueue addOperationWithBlock: ^{
        FaceMatchResult* result = [self.faceRecognition searchForFace: notification.object];

        // No face found
        if (!result.personID || [result.personID isEqual: @-1]) {
            NamelessPerson* person = [NamelessPerson object];
            person.image = notification.object;
            person.captured = [NSDate date];

            [[NamelessMasses object] addPerson: person];
            return;
        }

        Person* person = [[KnownPeople object] getPerson: result.personID.intValue];
        [self speak: [NSString stringWithFormat: @"Person Found: %@", person.name]];
    }];
}

@end