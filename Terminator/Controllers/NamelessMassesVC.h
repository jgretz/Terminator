//
//  MainVC.h
//  Terminator
//
//  Created by Joshua Gretz on 11/29/13.
//  Copyright (c) 2013 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamelessMassesVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong) IBOutlet UITableView* massesTable;

@end
