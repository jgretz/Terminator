//
//  SquareCam.h
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SquareCam : NSObject

@property (strong) UIImage* mostRecentImage;

-(void) startCapturing;
-(void) stopCapturing;

-(void) useCamera: (AVCaptureDevicePosition) devicePosition;
@end
