//
//  Terminator.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "Terminator.h"
#import "LightSensor.h"
#import "SquareCam.h"

@interface Terminator()

@property (strong) SquareCam* squareCam;
@property (strong) LightSensor* lightSensor;

@end

@implementation Terminator

-(void) startup {
    [self.squareCam startCapturing];
}

-(void) standdown {
    [self.squareCam stopCapturing];
}

@end
