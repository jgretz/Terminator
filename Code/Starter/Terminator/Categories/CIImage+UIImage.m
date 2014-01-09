//
// Created by Joshua Gretz on 1/7/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "CIImage+UIImage.h"


@implementation CIImage(UIImage)

-(UIImage*) uiImage {
    return [UIImage imageWithCIImage: self scale: 1 orientation: UIImageOrientationUp];
}

@end