//
//  APIConnection.h
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define TERMOSTAT_HOST @"http://localhost:3000/"
#define TERMOSTAT_HOST @"http://192.168.2.116:3000/"

@interface APIConnection : NSObject

+ (instancetype)sharedInstance;

- (void)allTermostatsWithCompletionhandler:(void (^)(NSArray *thermostats))handler;
- (void)addTermostatWith:(NSString *)name termostatID:(int)termostatID temperature:(float)temperature withCompletionhandler:(void (^)(bool success))handler;

- (void)editTermostat:(int)termostatID withName:(NSString *)name temperature:(float)temperature withCompletionhandler:(void (^)(bool success))handler;

@end
