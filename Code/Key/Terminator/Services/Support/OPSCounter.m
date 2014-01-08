//
// Created by Joshua Gretz on 1/7/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "OPSCounter.h"

@implementation OPSCounter {
    NSDate* compSecond;
    int opsTotal;
    int secondCount;
}

-(void) addOperationAt: (NSDate*) time {
    if (!compSecond) {
        compSecond = time;
        opsTotal = 1;
        return;
    }

    opsTotal++;
    if ([time timeIntervalSinceDate: compSecond] <= 1)
        return;

    secondCount++;

    self.ops = (float) opsTotal / (float) secondCount;

    compSecond = time;

    // reset at 5K
    if (opsTotal > 5000) {
        opsTotal = (int) self.ops;
        secondCount = 1;
    }
}

@end