//
//  CollectionViewCell.h
//  CanaryWeatherApp
//
//  Created by Natalia Estrella on 4/13/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end
