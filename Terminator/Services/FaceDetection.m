//
// Created by Joshua Gretz on 11/29/13.
// Copyright (c) 2013 gretz. All rights reserved.



#import "FaceDetection.h"


@implementation FaceDetection

-(NSArray*) detectFaces: (UIImage*) rawImage {
    CIImage* image = [CIImage imageWithCGImage: rawImage.CGImage];

    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options: @{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    return [detector featuresInImage: image];
}

@end