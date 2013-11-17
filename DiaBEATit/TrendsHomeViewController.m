//
//  TrendsHomeViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "TrendsHomeViewController.h"
#import "SDSegmentedControl.h"

@interface TrendsHomeViewController ()
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentedControl;

@end

@implementation TrendsHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    ((SDSegmentedControl *)_segmentedControl).arrowHeightFactor *= -1.0;
    self.segmentedControl.scrollView.contentOffset = CGPointMake(0,65);
    self.segmentedControl.scrollView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
