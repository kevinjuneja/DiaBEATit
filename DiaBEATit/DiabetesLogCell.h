//
//  DiabetesLogCell.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/20/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiabetesLogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *analysis;
@property (weak, nonatomic) IBOutlet UILabel *glucoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *a1cLabel;
@property (weak, nonatomic) IBOutlet UILabel *a1cNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeOfDayImage;
@property (nonatomic) int logId;
@end
