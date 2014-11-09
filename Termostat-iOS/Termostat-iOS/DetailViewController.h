//
//  DetailViewController.h
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thermostat.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *idTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, strong) IBOutlet UISlider *temperatureSlider;

@property (nonatomic, strong) IBOutlet Thermostat *selectedThermostat;

- (IBAction)temperatureSliderMoved:(id)sender;
- (IBAction)editThermostatButtonPressed:(id)sender;

- (IBAction)enteredValue:(id)sender;

@end
