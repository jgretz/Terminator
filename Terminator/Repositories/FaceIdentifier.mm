//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "FaceIdentifier.h"
#import "FaceCapture.h"

#import "FaceDetector.h"
#import "CustomFaceRecognizer.h"
#import "UIImage+OpenCV.h"
#import "FaceMatchResult.h"
#import "Cerealizer.h"

@interface FaceIdentifier()

@property (strong) NSMutableArray* facesToSearch;

@property (strong) CustomFaceRecognizer* faceRecognizer;

@end

@implementation FaceIdentifier

const double searchInterval = 1;

-(id) init {
    if ((self = [super init])) {
        self.facesToSearch = [NSMutableArray array];

        [self setupOpenCV];

        [self performSelector: @selector(performSearch) withObject: nil afterDelay: searchInterval];
    }

    return self;
}

-(void) setupOpenCV {
    self.faceRecognizer = [[CustomFaceRecognizer alloc] initWithFisherFaceRecognizer];
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
        cv::Mat mat = faceCapture.faceImage.CVMat;

        cv::Rect rect = cvRect(0, 0, (int) faceCapture.faceImage.size.width, (int) faceCapture.faceImage.size.height);
        NSDictionary* rawMatch = [self.faceRecognizer recognizeFace: rect inImage: mat];

        FaceMatchResult* matchResult = [[Cerealizer object] create: [FaceMatchResult class] fromDictionary: rawMatch];

        if (!matchResult.personID || [matchResult.personID isEqual: @-1]) {
            NSLog(@"No Match Found");
            continue;
        }

        NSLog(@"Match Found");
    }

    [self performSelector: @selector(performSearch) withObject: nil afterDelay: searchInterval];
}

@end