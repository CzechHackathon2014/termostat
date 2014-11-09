//
//  AddThermostatViewController.m
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import "AddThermostatViewController.h"
#import "APIConnection.h"

@interface AddThermostatViewController ()

@end

@implementation AddThermostatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)temperatureSliderMoved:(id)sender
{
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f °C", self.temperatureSlider.value];
}

- (void)addThermostatButtonPressed:(id)sender
{
    [[APIConnection sharedInstance] addTermostatWith:self.nameTextField.text termostatID:[self.idTextField.text intValue] temperature:self.temperatureSlider.value withCompletionhandler:^(bool success) {
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
