//
//  ThermostatTableViewCell.h
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThermostatTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *actualTemperature;
@property (nonatomic, strong) IBOutlet UILabel *preferedTemperature;

@end
