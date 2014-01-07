//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "CameraRoll.h"
#import "ImageCapture.h"

@interface CameraRoll()

@end

@implementation CameraRoll

-(id) init {
    if ((self = [super init])) {
        self.capturedImages = [NSMutableArray array];
    }

    return self;
}

-(void) pushImage: (ImageCapture*) image {
    @synchronized (self) {
        [self.capturedImages addObject: image];
    }
}

-(NSArray*) pop {
    @synchronized (self) {
        NSArray* images = [NSArray arrayWithArray: self.capturedImages];
        [self.capturedImages removeAllObjects];

        return images;
    }
}

@end