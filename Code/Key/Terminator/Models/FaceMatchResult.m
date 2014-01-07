//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "FaceMatchResult.h"


@implementation FaceMatchResult

-(float) confidenceDecimal {
    NSNumberFormatter *confidenceFormatter = [[NSNumberFormatter alloc] init];
    [confidenceFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    confidenceFormatter.maximumFractionDigits = 2;

    return [confidenceFormatter numberFromString: self.confidence].floatValue;

}

@end