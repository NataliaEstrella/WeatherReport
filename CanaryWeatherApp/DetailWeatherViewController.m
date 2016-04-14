//
//  DetailWeatherViewController.m
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/13/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import "DetailWeatherViewController.h"

@interface DetailWeatherViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *maxWeather;
@property (weak, nonatomic) IBOutlet UILabel *minWeather;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation DetailWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLabelsToAPIInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLabelsToAPIInfo {
    
    NSLog(@"self.weather %@", self.weather);
    self.iconImage.image = [UIImage imageNamed:self.weather.image];
    self.maxWeather.text = self.weather.tempMax;
    self.minWeather.text = self.weather.tempMin;
    self.summaryLabel.text = self.weather.summary;
}

@end
