//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>
#import "Cerealizable.h"

typedef enum {
    StandingNeutral = 0,
    StandingAlly = 1,
    StandingEnemy = 2
} Standing;


@interface Person : NSObject<Cerealizable>

@property (nonatomic) int id;
@property (copy) NSString* name;
@property (copy) NSString* azureId;

@property (strong) NSMutableArray* images;

@property (nonatomic) Standing standing;

@end