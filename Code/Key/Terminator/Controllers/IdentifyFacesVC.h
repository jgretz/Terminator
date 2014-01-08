//
//  IdentifyFacesVC.h
//  Terminator
//
//  Created by Joshua Gretz on 1/2/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface IdentifyFacesVC : BaseVC<UITableViewDataSource, UITableViewDelegate>

@property (strong) NSArray* selectedPeopleToIdentify;

@property (strong) IBOutlet UITextField* nameTextField;
@property (strong) IBOutlet UITableView* existingTableView;

-(IBAction) addNewPerson;
-(IBAction) addToExisting;

@end
