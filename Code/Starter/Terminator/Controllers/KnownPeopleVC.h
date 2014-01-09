//
//  KnownPeopleVC.h
//  Terminator
//
//  Created by Joshua Gretz on 12/31/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface KnownPeopleVC : BaseVC<UITableViewDataSource, UITableViewDelegate>

@property (strong) IBOutlet UITableView* peopleTableView;

@end
