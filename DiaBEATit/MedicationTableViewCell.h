//
//  MedicationTableViewCell.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/16/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *medicationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *medicationDosageLabel;
@property (weak, nonatomic) IBOutlet UILabel *medicationQuantityLabel;
@property (nonatomic) int mID;
@end
