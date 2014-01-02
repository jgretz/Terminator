//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "FaceLibrary.h"
#import "FaceCapture.h"
#import "ReKognitionSDK.h"
#import "Constants.h"
#import "ReKognition.h"


@interface FaceLibrary()

@property (strong) NSMutableArray* facesToSearch;
@property (strong) NSMutableArray* listeners;

@end

@implementation FaceLibrary

const double searchInterval = 1;

-(id) init {
    if ((self = [super init])) {
        self.faces = [NSMutableArray array];
        self.facesToSearch = [NSMutableArray array];

        self.listeners = [NSMutableArray array];

        [self performSelector: @selector(performSearch) withObject: nil afterDelay: searchInterval];
    }

    return self;
}

-(void) addFaceToLibrary: (FaceCapture*) faceCapture {
    @synchronized (self) {
        [self.facesToSearch addObject: faceCapture];
    }
}

#pragma mark - Search
-(void) performSearch {
    NSArray* searchItems = nil;
    @synchronized (self) {
        searchItems = [NSArray arrayWithArray: self.facesToSearch];
        [self.facesToSearch removeAllObjects];
    }

    int index = 0;
    [self performBlockInBackground: ^{
        if (index >= searchItems.count) {
            [self performBlockInMainThread: ^{
                [self performSelector: @selector(performSearch) withObject: nil afterDelay: searchInterval];
            }];
            return;
        }

        FaceCapture* faceCapture = searchItems[index];

        NSArray* results = [[ReKognition object] searchForImage: faceCapture.faceImage];
    }];

}

#pragma mark - Notification
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