//
//  TerminatorVC.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "TerminatorVC.h"
#import "Terminator.h"

@interface TerminatorVC ()

@end

@implementation TerminatorVC

-(id) init {
    if ((self = [super init])) {
        self.title = @"Terminator";
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(displayMessage:) name: [Constants TeminatorMessage] object: nil];
}

-(void) displayMessage: (NSNotification*) notification {
    [self performBlockInMainThread: ^{
        self.textView.text = [(NSString*) notification.object stringByAppendingFormat: @"\n%@", self.textView.text];
    }];
}

@end
