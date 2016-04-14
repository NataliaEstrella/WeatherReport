//
//  APIManager.h
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/12/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface APIManager : NSObject

//+ (void) makeRequest:completion:(void(^)(NSMutableArray *data))completion;
//+ (void)makeRequest:(void(^)(NSMutableArray *data))completion;

+ (void)makeRequestWithLocation:(CLLocation *)location
       withLCompletion:(void(^)(NSMutableArray *data))completion;


@end
