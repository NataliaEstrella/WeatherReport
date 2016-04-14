//
//  APIManager.m
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/12/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import "APIManager.h"
#import "WeatherManager.h"
#import <AFNetworking/AFNetworking.h>


@implementation APIManager

+ (void)makeRequestWithLocation:(CLLocation *)location
                withLCompletion:(void(^)(NSMutableArray *data))completion

{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableArray *weatherReport = [[NSMutableArray alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"https://api.forecast.io/forecast/f2ad11730c309f0637ba276c1217f0c0/%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    NSLog(@" lat and long %@, %@", @(location.coordinate.latitude), @(location.coordinate.longitude));
    
    [manager GET:url
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * task, id responseObject)
    
    {
             if (responseObject != nil) {
                 
                 NSArray *results = [[responseObject objectForKey:@"daily"] objectForKey:@"data"];
                 
                 for (NSDictionary *result in results) {
                     WeatherManager *object = [[WeatherManager alloc] init];
                     
                     NSNumber *dateTime = [result objectForKey:@"time"];
                     NSDate *day = [NSDate dateWithTimeIntervalSinceReferenceDate:[dateTime doubleValue]];
                     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                     [dateFormatter setDateFormat: @"EEEE"];
                     NSString *dayOfWeek = [dateFormatter stringFromDate:day];
                     object.day = dayOfWeek;

                     
                     NSString *image = [result objectForKey:@"icon"];
                     object.image = image;
                     
                     double maxTemp = [[result objectForKey:@"temperatureMax"]doubleValue];
                     object.tempMax = [NSString stringWithFormat:@"%.02f", maxTemp];

                     double minTemp = [[result objectForKey:@"temperatureMin"]doubleValue];
                     object.tempMin = [NSString stringWithFormat:@"%.02f", minTemp];
                     
                     NSString *summary = [result objectForKey:@"summary"];
                     object.summary = summary;
                     
                     
                     [weatherReport addObject:object];
                     
                     NSLog(@"Max temp: %@", @(maxTemp));
                     
                 }
                 completion(weatherReport);
                 NSLog(@"JSON Party: %@", results);

             }
             
         }
         failure:^(NSURLSessionDataTask * task, NSError * error) {
             NSLog(@"makeResquest is all killer no filler: %@", error);
             
         }];
}


@end
