//
//  LaunchViewController.m
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/14/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import "LaunchViewController.h"
#import "DGActivityIndicatorView.h"
#import "WeatherCollectionViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTransitionAmination];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"maybe" sender:self];
   
    });
}



-(void)customTransitionAmination {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSArray *activityTypes = @[
//                                                              @(DGActivityIndicatorAnimationTypeNineDots),
                               //                               @(DGActivityIndicatorAnimationTypeTriplePulse),
                               //                               @(DGActivityIndicatorAnimationTypeFiveDots),
//                                                              @(DGActivityIndicatorAnimationTypeRotatingSquares),
//                                                              @(DGActivityIndicatorAnimationTypeDoubleBounce),
//                                                              @(DGActivityIndicatorAnimationTypeTwoDots),
                               //                               @(DGActivityIndicatorAnimationTypeThreeDots),
                               //                               @(DGActivityIndicatorAnimationTypeBallPulse),
                               //                               @(DGActivityIndicatorAnimationTypeBallClipRotate),
                               //                               @(DGActivityIndicatorAnimationTypeBallClipRotatePulse),
                               //                               @(DGActivityIndicatorAnimationTypeBallClipRotateMultiple),
                               //                               @(DGActivityIndicatorAnimationTypeBallRotate),
//                                                              @(DGActivityIndicatorAnimationTypeBallZigZag),
                               //                               @(DGActivityIndicatorAnimationTypeBallZigZagDeflect),
                               //                               @(DGActivityIndicatorAnimationTypeBallTrianglePath),
                               //                               @(DGActivityIndicatorAnimationTypeBallScale),
                               //                               @(DGActivityIndicatorAnimationTypeLineScale),
//                                                              @(DGActivityIndicatorAnimationTypeLineScaleParty),
//                                                              @(DGActivityIndicatorAnimationTypeBallScaleMultiple),
                               //                               @(DGActivityIndicatorAnimationTypeBallPulseSync),
                               //                               @(DGActivityIndicatorAnimationTypeBallBeat),
                               //                               @(DGActivityIndicatorAnimationTypeLineScalePulseOut),
                               //                               @(DGActivityIndicatorAnimationTypeLineScalePulseOutRapid),
                               //                               @(DGActivityIndicatorAnimationTypeBallScaleRipple),
                               //                               @(DGActivityIndicatorAnimationTypeBallScaleRippleMultiple),
                                                              @(DGActivityIndicatorAnimationTypeTriangleSkewSpin),
                               //                               @(DGActivityIndicatorAnimationTypeBallGridBeat),
//                                                              @(DGActivityIndicatorAnimationTypeBallGridPulse),
//                                                              @(DGActivityIndicatorAnimationTypeRotatingSandglass),
//                                                              @(DGActivityIndicatorAnimationTypeRotatingTrigons),
                               //                               @(DGActivityIndicatorAnimationTypeTripleRings),
//                               @(DGActivityIndicatorAnimationTypeCookieTerminator),
                               //                               @(DGActivityIndicatorAnimationTypeBallSpinFadeLoader)
                               ];
    
    for (int i = 0; i < activityTypes.count; i++) {
        DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[activityTypes[i] integerValue] tintColor:[UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0]];
        CGFloat width = self.view.bounds.size.width / 20.0f;
        CGFloat height = self.view.bounds.size.height / 20.0f;
        
        activityIndicatorView.frame = CGRectMake(width * (i % 100), height * (int)(i / 100), width, height);
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [activityIndicatorView setCenter:self.view.center];
    }
    
    
}



@end
