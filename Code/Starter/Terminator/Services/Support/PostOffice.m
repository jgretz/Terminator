//
// Created by Joshua Gretz on 1/8/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "PostOffice.h"

@interface PostOffice()

@property (strong) NSMutableDictionary* routes;

@end

@implementation PostOffice

-(id) init {
    if ((self = [super init])) {
        self.routes = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void) postMessage: (NSString*) message paylod: (id) payload {
    NSArray* targets = nil;
    @synchronized (self) {
        targets = self.routes[message];
    }

    for (MessageReceipt onReceipt in targets)
        onReceipt(payload);
}

-(void) listenForMessage: (NSString*) message onReceipt: (MessageReceipt) onReceipt {
    @synchronized (self) {
        NSMutableArray* list = self.routes[message];
        if (!list)
            list = self.routes[message] = [NSMutableArray array];

        [list addObject: onReceipt];
    }
}

@end