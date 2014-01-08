//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.

#import "FaceDetection.h"
#import "OPSCounter.h"

@interface FaceDetection()

@property (strong) OPSCounter* ipsCounter;

@end

@implementation FaceDetection

-(float) imagesProcessedPerSecond {
    return self.ipsCounter.ops;
}

-(void) detectFaces: (CIImage*) image {
    CIDetector* detector = [CIDetector detectorOfType: CIDetectorTypeFace context: nil options: @{ CIDetectorAccuracy : CIDetectorAccuracyLow }];

    NSArray* features = [detector featuresInImage: image options: @{ CIDetectorImageOrientation : @1 }];
    if (features.count == 0) {
        [self.ipsCounter addOperationAt: [NSDate date]];
        return;
    }

    // capture the people in the image
    for (CIFaceFeature* face in features) {
        // crop
        CIImage* workingImage = [image imageByCroppingToRect: face.bounds];

        // save
        CIContext* context = [CIContext contextWithOptions: nil];
        CGImageRef passThrough = [context createCGImage: workingImage fromRect: workingImage.extent];

        [[NSNotificationCenter defaultCenter] postNotificationName: [Constants FacesFoundInImage] object: [UIImage imageWithCGImage: passThrough]];
    }

    [self.ipsCounter addOperationAt: [NSDate date]];

}

@end