//
// Created by Joshua Gretz on 1/8/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import <Foundation/Foundation.h>

typedef void(^MessageReceipt)(id);

@interface PostOffice : NSObject

-(void) postMessage: (NSString*) message paylod: (id) payload;
-(void) listenForMessage: (NSString*) message onReceipt: (MessageReceipt) onReceipt;

@end