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
#import "PostOffice.h"

@interface Brain()

@property (strong) FaceDetection* faceDetection;
@property (strong) OpenCVFaceRecognition* faceRecognition;

@property (strong) PostOffice* postOffice;

@property (strong) NSOperationQueue* detectFacesQueue;
@property (strong) NSOperationQueue* searchForPeopleQueue;

@property (nonatomic) BOOL running;

@end

@implementation Brain

-(void) startup {
    self.running = YES;

    self.detectFacesQueue = [[NSOperationQueue alloc] init];
    self.detectFacesQueue.maxConcurrentOperationCount = 1;
    [self.postOffice listenForMessage: [Constants ImageAddedToCameraRoll] onReceipt: ^(NSDictionary* payload) { [self imageAddedToCameraRoll: payload]; }];

    self.searchForPeopleQueue = [[NSOperationQueue alloc] init];
    self.searchForPeopleQueue.maxConcurrentOperationCount = 1;
    [self.postOffice listenForMessage: [Constants FacesFoundInImage] onReceipt: ^(UIImage* payload) { [self facesFoundInImage: payload]; }];

}

-(void) shutdown {
    self.running = NO;
}

#pragma mark - Detect Faces From Images Seen
-(void) imageAddedToCameraRoll: (NSDictionary*) payload {
    if (!self.running)
        return;

    NSDate* timestamp = payload[[Constants Timestamp]];
    if ([[NSDate date] timeIntervalSinceDate: timestamp] > 1.1)
        return;

    [self.detectFacesQueue addOperationWithBlock: ^{
        [self.faceDetection detectFaces: payload[[Constants Image]]];
    }];
}

#pragma mark - Search Faces For Known People
-(void) facesFoundInImage: (UIImage*) image {
    if (!self.running)
        return;

    [self.searchForPeopleQueue addOperationWithBlock: ^{
        FaceMatchResult* result = [self.faceRecognition searchForFace: image];

        // No face found
        if (!result.personID || [result.personID isEqual: @-1]) {
            NamelessPerson* person = [NamelessPerson object];
            person.image = image;
            person.captured = [NSDate date];

            [[NamelessMasses object] addPerson: person];
            return;
        }

        [self speak: [NSString stringWithFormat: @"Person Found: %@", result.personName]];
    }];
}

@end