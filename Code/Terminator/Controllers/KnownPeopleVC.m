//
//  KnownPeopleVC.m
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import "KnownPeopleVC.h"
#import "KnownPeople.h"
#import "Person.h"

@interface KnownPeopleVC()

@property (strong) KnownPeople* knownPeople;
@property (strong) NSArray* data;

@end

@implementation KnownPeopleVC

const int knowPeopleRefreshRate = 5;

-(id) init {
    if ((self = [super init])) {
        self.title = @"Known People";
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    [self loadData];
}

-(void) loadData {
    self.data = [self.knownPeople.allPeople sortedArrayUsingComparator: ^NSComparisonResult(Person* obj1, Person* obj2) {
        return [obj1.name compare: obj2.name];
    }];
    [self.peopleTableView reloadData];

    [self performSelector: @selector(loadData) withObject: nil afterDelay: knowPeopleRefreshRate];
}

-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return self.data.count;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];

    Person* person = self.data[indexPath.row];

    cell.textLabel.text = person.name;
    cell.imageView.image = person.images.count > 0 ? person.images[0] : nil;

    return cell;
}


@end
