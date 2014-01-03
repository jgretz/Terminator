//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "Person.h"


@implementation Person

-(Class) classTypeForKey: (NSString*) key {
    if ([key isEqual: SELF_KEYPATH(images)])
        return [UIImage class];
    return nil;
}

@end