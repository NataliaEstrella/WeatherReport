//
//  WeatherManager.h
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/13/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

@property (nonatomic) NSString *image;
@property (nonatomic) NSString *tempMax;
@property (nonatomic) NSString *tempMin;
@property (nonatomic) NSString *day;
@property (nonatomic) NSString *summary;

@end
