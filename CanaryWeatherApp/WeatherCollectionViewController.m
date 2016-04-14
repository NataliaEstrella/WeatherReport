//
//  WeatherCollectionViewController.m
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/12/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import "WeatherCollectionViewController.h"
#import "APIManager.h"
#import "CollectionViewCell.h"
#import "WeatherManager.h"
#import "DetailWeatherViewController.h"




@interface WeatherCollectionViewController ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *location;

@property (nonatomic) NSMutableArray *results;

@end

@implementation WeatherCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifier = @"CustomCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.results = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc]init];
    
    [self getData];


    // Register cell classes
    UINib *customCollectionCellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:customCollectionCellNib forCellWithReuseIdentifier:reuseIdentifier];

    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.locationManager requestAlwaysAuthorization];
     self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];

//    [self customTransitionAmination];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
       return self.results.count;
//    return 29;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    WeatherManager *currentResult = self.results[indexPath.row];
    
    
    NSString *maxTemp = currentResult.tempMax;
    cell.tempLabel.text = maxTemp;
    
    NSString *image = currentResult.image;
    cell.weatherImage.image = [UIImage imageNamed:image];
    
    NSString *day = currentResult.day;
    cell.dayLabel.text = day;


    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"DetailSegue" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        NSIndexPath *indexPath = sender;
        DetailWeatherViewController *vc = segue.destinationViewController;
        vc.weather = [self.results objectAtIndex:indexPath.row];
    }
}

-(void)getData {
    
    [APIManager makeRequestWithLocation:self.location
                        withLCompletion:^(NSMutableArray *data) {
                            self.results = data;
                            [self.collectionView reloadData];
                            
                        }];

}

#pragma mark <UICollectionViewDelegate>
@end
