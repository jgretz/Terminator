//
//  MainVC.m
//  Terminator
//
//  Created by Joshua Gretz on 11/29/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "CaptureVC.h"
#import "CameraRoll.h"
#import "ImageCapture.h"
#import "FaceCapture.h"
#import "FaceIdentifier.h"

@interface CaptureVC()

@end

@implementation CaptureVC

-(id) init {
    if ((self = [super init])) {
        self.title = @"Capture";
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

//    [[FaceLibrary object] registerForNewFaceNotification: ^(FaceCapture* capture) {
//        [self performBlockInMainThread: ^{
//            self.currentView.image = capture.faceImage;
//        }];
//    }];
}

@end
