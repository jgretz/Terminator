//
//  KnownPeopleVC.h
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnownPeopleVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong) IBOutlet UITableView* peopleTableView;

@end
