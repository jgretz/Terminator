//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "OpenCVFaceRecognition.h"

#import "CustomFaceRecognizer.h"
#import "UIImage+OpenCV.h"
#import "FaceMatchResult.h"
#import "Person.h"
#import "Cerealizer.h"

@interface OpenCVFaceRecognition()

@property (nonatomic) BOOL canSearch;

@property (strong) CustomFaceRecognizer* faceRecognizer;

@end

@implementation OpenCVFaceRecognition

-(id) init {
    if ((self = [super init])) {
        [self setupOpenCV];
    }

    return self;
}

-(void) setupOpenCV {
    self.faceRecognizer = [[CustomFaceRecognizer alloc] initWithEigenFaceRecognizer];
}

#pragma mark - Train
-(int) creatNewPersonNamed: (NSString*) name {
    return [self.faceRecognizer newPersonWithName: name];
}

-(void) learnFace: (UIImage*) image forPerson: (Person*) person {
    cv::Mat mat = image.CVMat;
    cv::Rect rect = cvRect(0, 0, (int) image.size.width, (int) image.size.height);

    [self.faceRecognizer learnFace: rect ofPersonID: person.id fromImage: mat];
}

-(void) train {
    self.canSearch = [self.faceRecognizer trainModel];
}

#pragma mark - Search
-(FaceMatchResult*) searchForFace: (UIImage*) image {
    if (!self.canSearch)
        return nil;

    cv::Mat mat = image.CVMat;
    cv::Rect rect = cvRect(0, 0, (int) image.size.width, (int) image.size.height);

    NSDictionary* rawMatch = [self.faceRecognizer recognizeFace: rect inImage: mat];
    return [[Cerealizer object] create: [FaceMatchResult class] fromDictionary: rawMatch];
}

@end