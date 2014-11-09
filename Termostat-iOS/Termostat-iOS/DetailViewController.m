//
//  DetailViewController.m
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import "DetailViewController.h"
#import "APIConnection.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.idTextField.text = [NSString stringWithFormat:@"%i", self.selectedThermostat.thermostatID];
    self.nameTextField.text = self.selectedThermostat.name;
    
    self.temperatureSlider.value = self.selectedThermostat.presetTemperature;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f °C", self.temperatureSlider.value];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)temperatureSliderMoved:(id)sender
{
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f °C", self.temperatureSlider.value];
}

- (void)editThermostatButtonPressed:(id)sender
{
    [[APIConnection sharedInstance] editTermostat:[self.idTextField.text intValue] withName:self.nameTextField.text temperature:self.temperatureSlider.value withCompletionhandler:^(bool success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            //error
        }
    }];
    
}

- (void)enteredValue:(id)sender
{
    [self.idTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
