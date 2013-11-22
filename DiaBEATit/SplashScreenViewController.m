//
//  SplashScreenViewController.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/16/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "Profile.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *__autoreleasing*error = NULL;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    
    NSLog(@"%@", path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[ NSBundle mainBundle] pathForResource:@"diaBEATit" ofType:@"sqlite3"];
        [fileManager copyItemAtPath: bundle toPath:path error:error];
    }
    
    Profile *profile = [[Profile alloc] init];
    [profile saveProfileLogWithName:@"Kevin" age:@"22" gender:@"M" height:@"5'11" weight:@"185" insulinDependency:@"Yes" targetGlucose:@"130" targetSystolicBP:@"140" targetDiastolicBP:@"70"];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(goToNext:) userInfo:nil repeats:NO];

}

-(void)goToNext:(id)sender {
    [self performSegueWithIdentifier:@"splashSegue" sender:sender];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
