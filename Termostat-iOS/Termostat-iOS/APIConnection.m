//
//  APIConnection.m
//  Termostat-iOS
//
//  Created by Jura Ibl on 08/11/14.
//  Copyright (c) 2014 Martin Wenisch. All rights reserved.
//

#import "APIConnection.h"
#import <MBProgressHUD.h>

@implementation APIConnection

static APIConnection *sharedInstance;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIConnection alloc] init];
    });
    
    return sharedInstance;
}

- (void)allTermostatsWithCompletionhandler:(void (^)(NSArray *))handler
{    
    NSString *urlString = [NSString stringWithFormat:@"%@termostats", TERMOSTAT_HOST];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    if (error == nil) {
                                                        if ([response.MIMEType isEqualToString:@"application/json"]) {
                                                            if (data) {
                                                                NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                handler(jsonData);
                                                            } else {
                                                                NSLog(@"Termostats empty data");
                                                                handler(nil);
                                                            }
                                                        } else {
                                                            NSLog(@"Termostats wrong mime type");
                                                            handler(nil);
                                                        }
                                                    } else {
                                                        NSLog(@"Termostats request error: %@", error);
                                                        handler(nil);
                                                    }
                                                });
                                            }];
    [task resume];
}

- (void)addTermostatWith:(NSString *)name termostatID:(int)termostatID temperature:(float)temperature withCompletionhandler:(void (^)(bool))handler
{
    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    
    NSDictionary *bodyDictionary = @{@"name": name, @"termostat_id": @(termostatID), @"temperature": @(temperature)};
    NSData *data = [NSJSONSerialization dataWithJSONObject:bodyDictionary options:0 error:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@add_termostat", TERMOSTAT_HOST];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
                                                    if (error == nil) {
                                                        if ([response.MIMEType isEqualToString:@"application/json"]) {
                                                            if (data) {
                                                                handler(YES);
                                                            } else {
                                                                NSLog(@"Add response empty data");
                                                                handler(NO);
                                                            }
                                                        } else {
                                                            NSLog(@"Add response wrong MIME type");
                                                            handler(NO);
                                                        }
                                                    } else {
                                                        NSLog(@"Add request error: %@", error);
                                                        handler(NO);
                                                    }
                                                });
                                            }];
    [task resume];
}

- (void)editTermostat:(int)termostatID withName:(NSString *)name temperature:(float)temperature withCompletionhandler:(void (^)(bool))handler
{
    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    
    NSDictionary *bodyDictionary = @{@"name": name, @"termostat_id": @(termostatID), @"temperature": @(temperature)};
    NSData *data = [NSJSONSerialization dataWithJSONObject:bodyDictionary options:0 error:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@update_termostat", TERMOSTAT_HOST];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
                                                    if (error == nil) {
                                                        if ([response.MIMEType isEqualToString:@"application/json"]) {
                                                            if (data) {
                                                                handler(YES);
                                                            } else {
                                                                NSLog(@"Add response empty data");
                                                                handler(NO);
                                                            }
                                                        } else {
                                                            NSLog(@"Add response wrong MIME type");
                                                            handler(NO);
                                                        }
                                                    } else {
                                                        NSLog(@"Add request error: %@", error);
                                                        handler(NO);
                                                    }
                                                });
                                            }];
    [task resume];
}



@end
