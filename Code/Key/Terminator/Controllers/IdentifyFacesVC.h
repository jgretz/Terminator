//
//  IdentifyFacesVC.h
//  Terminator
//
//  Created by Joshua Gretz on 1/2/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentifyFacesVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong) NSArray* selectedFacesToIdentify;

@property (strong) IBOutlet UITextField* nameTextField;
@property (strong) IBOutlet UITableView* existingTableView;

-(IBAction) addNewPerson;
-(IBAction) addToExisting;

@end
