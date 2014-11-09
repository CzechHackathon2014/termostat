//
//  AddThermostatViewController.h
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddThermostatViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *idTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, strong) IBOutlet UISlider *temperatureSlider;

- (IBAction)temperatureSliderMoved:(id)sender;
- (IBAction)addThermostatButtonPressed:(id)sender;

- (IBAction)enteredValue:(id)sender;
@end
