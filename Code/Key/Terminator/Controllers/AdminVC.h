//
//  AdminVC.h
//  Terminator
//
//  Created by Joshua Gretz on 1/7/14.
//  Copyright (c) 2014 gretz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface AdminVC : BaseVC<UITableViewDelegate, UITableViewDataSource>

@property (strong) IBOutlet UIView* cameraView;
@property (strong) IBOutlet UIImageView* cameraImageView;

@property (strong) IBOutlet UIView* faceView;
@property (strong) IBOutlet UIImageView* faceImageView;

@property (strong) IBOutlet UIView* danceView;

@property (strong) IBOutlet UIView* statsView;
@property (strong) IBOutlet UITableView* statsTableView;

@end
