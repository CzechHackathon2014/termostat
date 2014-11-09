//
//  ThermostatsViewController.h
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThermostatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
