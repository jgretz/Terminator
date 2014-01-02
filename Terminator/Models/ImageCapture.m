//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "ImageCapture.h"

@interface ImageCapture() {
    UIImage* resolvedUIImage;
}
@end

@implementation ImageCapture

-(UIImage*) uiImage {
    @synchronized (self) {
        if (!resolvedUIImage)
            resolvedUIImage = [UIImage imageWithCIImage: self.image scale: 1 orientation: (UIImageOrientation) self.deviceOrientation];
    }
    return resolvedUIImage;
}

@end