//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "FaceLibrary.h"
#import "FaceCapture.h"


@interface FaceLibrary()

@property (strong) NSMutableArray* listeners;

@end

@implementation FaceLibrary

-(id) init {
    if ((self = [super init])) {
        self.faces = [NSMutableArray array];
        self.listeners = [NSMutableArray array];
    }

    return self;
}

-(void) addFaceToLibrary: (FaceCapture*) faceCapture {

}

#pragma mark - Notfication
-(void) notifyListenersOfANewFace: (FaceCapture*) faceCapture {
    @synchronized (self) {
        for (FaceNotification notification in self.listeners)
            notification(faceCapture);
    }
}

-(void) registerForNewFaceNotification: (FaceNotification) faceNotification {
    @synchronized (self) {
        [self.listeners addObject: faceNotification];
    }
}

@end