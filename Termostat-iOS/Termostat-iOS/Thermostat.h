//
//  Thermostat.h
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thermostat : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int thermostatID;
@property (nonatomic) float currentTemperature;
@property (nonatomic) float presetTemperature;

@end
