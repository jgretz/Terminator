//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "Brain.h"
#import "ImageCapture.h"
#import "CameraRoll.h"
#import "FaceDetection.h"
#import "FaceCapture.h"
#import "FaceMatchResult.h"
#import "OpenCVFaceRecognition.h"
#import "NamelessMasses.h"
#import "KnownPeople.h"
#import "Person.h"

@interface Brain()

@property (strong) NSMutableArray* facesToSearch;

@property (strong) FaceDetection* faceDetection;
@property (strong) OpenCVFaceRecognition* faceRecognition;

@property (nonatomic) BOOL running;

@end

@implementation Brain

const double ageFilter = 1;
const double faceDetectionInterval = .5;
const double searchForPeopleInterval = 1;

-(void) startup {
    self.running = YES;
    self.facesToSearch = [NSMutableArray array];

    [self performSelector: @selector(detectFaces) withObject: nil afterDelay: faceDetectionInterval];
    [self performSelector: @selector(searchForPeople) withObject: nil afterDelay: searchForPeopleInterval];
}

-(void) shutdown {
    self.running = NO;
}

#pragma mark - Detect Faces From Images Seen
-(void) detectFaces {
    if (!self.running)
        return;

    NSArray* images = [[CameraRoll object] pop];

    [self performBlockInBackground: ^{
        for (ImageCapture* capture in images) {
            if ([[NSDate date] timeIntervalSinceDate: capture.captured] > ageFilter)
                continue;

            NSArray* facesFound = [self.faceDetection detectFaces: capture];

            @synchronized (self) {
                [self.facesToSearch addObjectsFromArray: facesFound];
            }
        };

        [self performBlockInMainThread: ^{
            [self performSelector: @selector(detectFaces) withObject: nil afterDelay: faceDetectionInterval];
        }];
    }];
}

#pragma mark - Search Faces For Known People
-(void) searchForPeople {
    if (!self.running)
        return;

    NSArray* searchItems = nil;
    @synchronized (self) {
        searchItems = [NSArray arrayWithArray: self.facesToSearch];
        [self.facesToSearch removeAllObjects];
    }

    [self performBlockInBackground: ^{
        for (FaceCapture* faceCapture in searchItems) {
            FaceMatchResult* result = [self.faceRecognition searchForFace: faceCapture.faceImage];

            // No face found
            if (!result.personID || [result.personID isEqual: @-1]) {
                [[NamelessMasses object] addFace: faceCapture];
                continue;
            }

            Person* person = [[KnownPeople object] getPerson: result.personID.intValue];
            [self speak: [NSString stringWithFormat: @"Person Found: %@", person.name]];
        }

        [self performBlockInMainThread: ^{
            [self performSelector: @selector(searchForPeople) withObject: nil afterDelay: searchForPeopleInterval];
        }];
    }];
}

@end