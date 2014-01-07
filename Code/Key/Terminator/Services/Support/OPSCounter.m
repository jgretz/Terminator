//
// Created by Joshua Gretz on 1/7/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "OPSCounter.h"


@implementation OPSCounter {
    NSDate* compSecond;
    int currentCount;
    int opsTotal;
    int secondCount;
}

-(void) addOperationAt: (NSDate*) time {
    if (!compSecond) {
        compSecond = time;
        currentCount = 1;
        return;
    }

    if ([time timeIntervalSinceDate: compSecond] < 1) {
        currentCount++;
        return;
    }

    opsTotal += currentCount + 1;
    secondCount++;

    self.ops =  opsTotal / secondCount;

    compSecond = time;
    currentCount = 0;
}

@end