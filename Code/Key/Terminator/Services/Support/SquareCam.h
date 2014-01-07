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

-(void) startCapturing;
-(void) stopCapturing;

-(void) useCameraPosition: (AVCaptureDevicePosition) devicePosition;

@end
