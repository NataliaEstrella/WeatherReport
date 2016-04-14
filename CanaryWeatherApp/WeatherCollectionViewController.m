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
#import "DGActivityIndicatorView.h"



@interface WeatherCollectionViewController ()<CLLocationManagerDelegate>

@property (nonatomic) DGActivityIndicatorView *loadingView;
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

    // Register cell classes
    UINib *customCollectionCellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:customCollectionCellNib forCellWithReuseIdentifier:reuseIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLocationManager];
    [self startLoading];
}

- (void)setupLocationManager {
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)startLoading {
   
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeTriangleSkewSpin tintColor:[UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0]];
    CGFloat width = self.view.bounds.size.width / 20.0f;
    CGFloat height = self.view.bounds.size.height / 20.0f;
    
    activityIndicatorView.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [activityIndicatorView setCenter:self.view.center];
    self.loadingView = activityIndicatorView;
    self.collectionView.alpha = 0;
    
}

- (void)stopLoading {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.loadingView.alpha = 0;
        self.collectionView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.loadingView stopAnimating];
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }];
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
//    cell.tempLabel.text = maxTemp;
    cell.tempLabel.text = [NSString stringWithFormat:@"%@ °F", maxTemp];
    
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [APIManager makeRequestWithLocation:self.location
                            withLCompletion:^(NSMutableArray *data) {
                                self.results = data;
                                [self.collectionView reloadData];
                                [self stopLoading];
                            }];
    });


}

#pragma mark <CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
    [self getData];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (self.location) return;
    if (!locations.lastObject) return;
    self.location = locations.lastObject;
    [self getData];
    [self.locationManager stopUpdatingLocation];
}


@end
