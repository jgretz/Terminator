//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "FaceIdentifier.h"
#import "FaceCapture.h"
//#import "CustomFaceRecognizer.h"

@interface FaceIdentifier()

@property (strong) NSMutableArray* facesToSearch;

//@property (strong) CustomFaceRecognizer* faceRecognizer;

@end

@implementation FaceIdentifier

const double searchInterval = 1;

-(id) init {
    if ((self = [super init])) {
        self.facesToSearch = [NSMutableArray array];

        [self performSelector: @selector(performSearch) withObject: nil afterDelay: searchInterval];
    }

    return self;
}

-(void) setupFaceRecognizer {
//    self.faceRecognizer = [[CustomFaceRecognizer alloc] initWithFisherFaceRecognizer];
}

#pragma mark - Search
-(void) identifyFace: (FaceCapture*) faceCapture {
    @synchronized (self) {
        [self.facesToSearch addObject: faceCapture];
    }
}

-(void) performSearch {
    NSArray* searchItems = nil;
    @synchronized (self) {
        searchItems = [NSArray arrayWithArray: self.facesToSearch];
        [self.facesToSearch removeAllObjects];
    }

    for (FaceCapture* faceCapture in searchItems) {

    }
}

@end