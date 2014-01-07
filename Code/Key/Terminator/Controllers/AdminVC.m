//
//  AdminVC.m
//  Terminator
//
//  Created by Joshua Gretz on 1/7/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import "AdminVC.h"
#import "CameraRoll.h"

@interface AdminVC()

@end

@implementation AdminVC

const NSTimeInterval statsRefreshRate = 1;

-(id) init {
    if ((self = [super init])) {
        self.title = @"Admin";
    }

    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;

    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems: @[ @"Camera", @"Faces", @"Dance", @"Stats" ]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget: self action: @selector(setSelectedIndex:) forControlEvents: UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;

    [self setSelectedIndex: segmentedControl];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(imageAddedToCameraRoll:) name: [Constants ImageAddedToCameraRoll] object: nil];

    [self refreshData];
}

-(void) setSelectedIndex: (UISegmentedControl*) segmentedControl {
    for (UIView* subView in self.view.subviews)
        subView.hidden = YES;
    [self.view.subviews[segmentedControl.selectedSegmentIndex] setHidden: NO];
}

-(void) refreshData {
    [self.statsTableView reloadData];

    [self performSelector: @selector(refreshData) withObject: nil afterDelay: statsRefreshRate];
}

-(void) imageAddedToCameraRoll: (NSNotification*) notification {
    [self.cameraImageView performSelectorOnMainThread: @selector(setImage:) withObject: notification.object waitUntilDone: NO];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return 1;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat: @"Camera FPS: %.2f", [[CameraRoll object] framesPerSecond]];
            break;
    }

    return cell;
}


@end
