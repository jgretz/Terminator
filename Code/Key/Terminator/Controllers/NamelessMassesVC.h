//
//  MainVC.h
//  Terminator
//
//  Created by Joshua Gretz on 11/29/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface NamelessMassesVC : BaseVC<UITableViewDelegate, UITableViewDataSource>

@property (strong) IBOutlet UITableView* massesTable;

@end
