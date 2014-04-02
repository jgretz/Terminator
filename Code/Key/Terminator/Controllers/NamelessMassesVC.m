//
//  MainVC.m
//  Terminator
//
//  Created by Joshua Gretz on 11/29/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "NamelessMassesVC.h"
#import "NamelessMasses.h"
#import "IdentifyFacesVC.h"
#import "NamelessPerson.h"
#import "PostOffice.h"

@interface NamelessMassesVC()

@property (strong) NSArray* data;
@property (strong) NSDateFormatter* dateFormatter;
@property (strong) NamelessMasses* namelessMasses;
@property (strong) PostOffice* postOffice;

@end

@implementation NamelessMassesVC

-(id) init {
    if ((self = [super init])) {
        self.title = @"Need ID";

        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat: @"hh:mm:ss a"];
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    [self displayEditOption];
    [self loadData];

    [self.postOffice listenForMessage: [Constants NamelessPersonFound] onReceipt: ^(id payload) {[self loadData];}];
}

-(void) loadData {
    [self performBlockInMainThread: ^{
        if (!self.massesTable.editing) {
            self.data = [self.namelessMasses.people sortedArrayUsingComparator: ^NSComparisonResult(NamelessPerson* obj1, NamelessPerson* obj2) {
                return [obj2.captured compare: obj1.captured];
            }];
            [self.massesTable reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return self.data.count;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];

    NamelessPerson* person = self.data[indexPath.row];

    cell.imageView.image = person.image;
    cell.textLabel.text = [NSString stringWithFormat: @"Captured on %@", [self.dateFormatter stringFromDate: person.captured]];

    return cell;
}

#pragma mark - Edit
-(void) displayEditOption {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Clear" style: UIBarButtonItemStyleDone target: self action: @selector(clear)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit target: self action: @selector(enterEditMode)];
}

-(void) enterEditMode {
    self.massesTable.allowsMultipleSelectionDuringEditing = YES;
    self.massesTable.editing = YES;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Next" style: UIBarButtonItemStyleDone target: self action: @selector(next)];
}

-(void) cancel {
    self.massesTable.editing = NO;
    [self displayEditOption];
}

-(void) clear {
    [self.namelessMasses clear];
    [self loadData];
}

-(void) next {
    NSMutableArray* selected = [NSMutableArray array];
    for (NSIndexPath* path in [self.massesTable indexPathsForSelectedRows])
        [selected addObject: self.data[path.row]];

    self.massesTable.editing = NO;
    [self displayEditOption];

    IdentifyFacesVC* vc = [IdentifyFacesVC object];
    vc.selectedPeopleToIdentify = selected;
    [self.navigationController pushViewController: vc animated: YES];
}


@end
