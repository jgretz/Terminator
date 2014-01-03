//
//  MainVC.m
//  Terminator
//
//  Created by Joshua Gretz on 11/29/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "NamelessMassesVC.h"
#import "FaceCapture.h"
#import "NamelessMasses.h"

@interface NamelessMassesVC()

@property (strong) NSArray* data;
@property (strong) NSDateFormatter* dateFormatter;

@end

@implementation NamelessMassesVC

const int refreshRate = 10;

-(id) init {
    if ((self = [super init])) {
        self.title = @"Masses";

        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat: @"hh:mm:ss a"];
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    [self performSelector: @selector(loadData) withObject: nil afterDelay: refreshRate];
}

-(void) loadData {
    self.data = [[[NamelessMasses object] faces] sortedArrayUsingComparator: ^NSComparisonResult(FaceCapture* obj1, FaceCapture* obj2) {
        return [obj2.captured compare: obj1.captured];
    }];
    [self.massesTable reloadData];

    [self performSelector: @selector(loadData) withObject: nil afterDelay: refreshRate];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(int) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return self.data.count;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];

    FaceCapture* capture = self.data[indexPath.row];

    cell.imageView.image = capture.faceImage;
    cell.textLabel.text = [NSString stringWithFormat: @"Captured on %@", [self.dateFormatter stringFromDate: capture.captured]];

    return cell;
}


@end
