//
//  HypertensionLogCell.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/20/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HypertensionLogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *analysis;
@property (weak, nonatomic) IBOutlet UILabel *systolicLabel;
@property (weak, nonatomic) IBOutlet UILabel *diastolicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeOfDayImage;
@end
