//
//  MedicationViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/20/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "MedicationViewController.h"
#import "Medication.h"

@interface MedicationViewController ()
@property (nonatomic, strong) Medication *med;
@end

@implementation MedicationViewController

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
    self.navigationItem.title = self.medToPass;
    self.med = [[Medication alloc] init];
    
    self.med = [self.med retrieveMedicationWithConstraints:self.medToPass];
    
    count.text = self.med.quantity;
    dose.text = self.med.dosage;
    
    if ([self.med.comments isEqualToString:@""]) {
       
        commentToHide.hidden = YES;
        comment.hidden = YES;
    }
    else{
        comment.text = self.med.comments;
    }
    
    NSString *fullURL = [NSString stringWithFormat:@"http://goodrx.com/%@",self.medToPass];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_goodRxWebView loadRequest:requestObj];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
