//
//  ThermostatsViewController.m
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import "ThermostatsViewController.h"
#import "ThermostatTableViewCell.h"
#import "APIConnection.h"
#import "Thermostat.h"
#import "DetailViewController.h"

@interface ThermostatsViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSTimer *refreshTimer;

@property (nonatomic, strong) Thermostat *selectedThermostat;

@end

@implementation ThermostatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(refreshThermostats) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshThermostats];
}

- (void)refreshThermostats
{
    [[APIConnection sharedInstance] allTermostatsWithCompletionhandler:^(NSArray *thermostats) {
        self.dataSource = [[NSMutableArray alloc] init];
        
        for (NSDictionary *th in thermostats) {
            Thermostat *thermostat = [[Thermostat alloc] init];
            thermostat.name = th[@"name"];
            thermostat.thermostatID = [th[@"termostat_id"] intValue];
            thermostat.currentTemperature = [th[@"currentTemperature"] floatValue];
            thermostat.presetTemperature = [th[@"temperature"] floatValue];
            
            [self.dataSource addObject:thermostat];
        }
        
        [self.tableView reloadData];
        
        
    }];
}

#pragma mark - UITableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataSource.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThermostatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThermostatTableViewCell" forIndexPath:indexPath];
    
    Thermostat *thermostat = (Thermostat *)self.dataSource[indexPath.row];
    
    cell.name.text = thermostat.name;
    cell.actualTemperature.text = [NSString stringWithFormat:@"%0.2f°C /", thermostat.currentTemperature];
    cell.preferedTemperature.text = [NSString stringWithFormat:@"%0.2f°C", thermostat.presetTemperature];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedThermostat = (Thermostat *)self.dataSource[indexPath.row];

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"EditThermostat"]) {
        DetailViewController *detail = (DetailViewController *)[segue destinationViewController];
        
        detail.selectedThermostat = self.selectedThermostat;
    }
    
}


@end
