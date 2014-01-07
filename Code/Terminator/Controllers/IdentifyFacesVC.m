//
//  IdentifyFacesVC.m
//  Terminator
//
//  Created by Joshua Gretz on 1/2/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import "IdentifyFacesVC.h"
#import "Person.h"
#import "Terminator.h"
#import "KnownPeople.h"
#import "FaceCapture.h"
#import "NamelessMasses.h"

@interface IdentifyFacesVC()

@property (strong) Terminator* terminator;
@property (strong) KnownPeople* knownPeople;

@property (strong) NSArray* people;

@end

@implementation IdentifyFacesVC

-(void) viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;

    [self loadData];
}

-(NSArray*) selectedImagesToIdentify {
    NSMutableArray* array = [NSMutableArray array];
    for (FaceCapture* face in self.selectedFacesToIdentify)
        [array addObject: face.faceImage];
    return array;
}

#pragma mark - IBActions
-(IBAction) addNewPerson {
    if (self.nameTextField.text.length == 0)
        return;

    [self.terminator rememberPersonNamed: self.nameTextField.text withImages: self.selectedImagesToIdentify];

    [self removeFacesAndPop];
}

-(IBAction) addToExisting {
    NSIndexPath* path = [self.existingTableView indexPathForSelectedRow];
    if (!path)
        return;

    Person* person = self.people[path.row];
    [self.terminator rememberAdditionalImages: self.selectedImagesToIdentify forPerson: person];

    [self removeFacesAndPop];
}

-(void) removeFacesAndPop {
    [[NamelessMasses object] removeFaces: self.selectedFacesToIdentify];
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
-(void) loadData {
    self.people = [self.knownPeople.allPeople sortedArrayUsingComparator: ^NSComparisonResult(Person* obj1, Person* obj2) {
        return [obj1.name compare: obj2.name];
    }];
    [self.existingTableView reloadData];
}

-(int) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return self.people.count;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];

    Person* person = self.people[indexPath.row];

    cell.textLabel.text = person.name;
    cell.imageView.image = person.images.count > 0 ? person.images[0] : nil;

    return cell;
}

@end
