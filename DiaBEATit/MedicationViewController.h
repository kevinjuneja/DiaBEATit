//
//  MedicationViewController.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/20/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicationViewController : UIViewController{
    IBOutlet UILabel *count;
    IBOutlet UILabel *dose;
    IBOutlet UILabel *commentToHide;
}
@property (nonatomic, strong) NSString *medToPass;
@property (strong, nonatomic) IBOutlet UIWebView *goodRxWebView;


@end
