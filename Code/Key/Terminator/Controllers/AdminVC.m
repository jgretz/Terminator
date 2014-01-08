//
//  AdminVC.m
//  Terminator
//
//  Created by Joshua Gretz on 1/7/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import "AdminVC.h"
#import "CameraRoll.h"
#import "CIImage+UIImage.h"
#import "FaceDetection.h"
#import "Terminator.h"

@interface AdminVC()

@property (strong) Terminator* terminator;

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

    // segmented control
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems: @[ @"Camera", @"Faces", @"Dance", @"Stats" ]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget: self action: @selector(setSelectedIndex:) forControlEvents: UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;

    [self setSelectedIndex: segmentedControl];

    // Subscribe to notifications
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(imageAddedToCameraRoll:) name: [Constants ImageAddedToCameraRoll] object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(facesFoundInImage:) name: [Constants FacesFoundInImage] object: nil];

    // stats
    [self refreshStatsData];
}

-(void) setSelectedIndex: (UISegmentedControl*) segmentedControl {
    for (UIView* subView in self.view.subviews)
        subView.hidden = YES;
    [self.view.subviews[segmentedControl.selectedSegmentIndex] setHidden: NO];
}

-(void) refreshStatsData {
    [self.statsTableView reloadData];

    [self performSelector: @selector(refreshStatsData) withObject: nil afterDelay: statsRefreshRate];
}

#pragma mark - Notifications
-(void) imageAddedToCameraRoll: (NSNotification*) notification {
    [self.cameraImageView performSelectorOnMainThread: @selector(setImage:) withObject: [(CIImage*) notification.object uiImage] waitUntilDone: NO];
}

-(void) facesFoundInImage: (NSNotification*) notification {
    [self.faceImageView performSelectorOnMainThread: @selector(setImage:) withObject: notification.object waitUntilDone: NO];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return 2;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat: @"Camera FPS: %.2f", [[CameraRoll object] framesPerSecond]];
            break;

        case 1:
            cell.textLabel.text = [NSString stringWithFormat: @"Face IPS: %.2f", [[FaceDetection object] imagesProcessedPerSecond]];
            break;
    }

    return cell;
}

#pragma mark - Dance
-(IBAction) turnRight {
    [self.terminator turnRight];
}

-(IBAction) turnLeft {
    [self.terminator turnLeft];
}

-(IBAction) goForward {
    [self.terminator goForward];
}

-(IBAction) goBackward {
    [self.terminator goBackward];
}

-(IBAction) tiltForward {
    [self.terminator tiltForward];
}

-(IBAction) tiltBackward {
    [self.terminator tiltBackward];
}

-(IBAction) stopTilt {
    [self.terminator stopTilt];
}

-(IBAction) toggleLED {
    [self.terminator toggleLED];
}


@end
