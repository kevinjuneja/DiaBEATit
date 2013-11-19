//
//  DiabetesLog.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Log.h"

@interface DiabetesLog : NSObject

@property (nonatomic, strong) NSString *glucose;
@property (nonatomic, strong) NSString *insulin;
@property (nonatomic, strong) NSString *a1c;
@property (nonatomic, strong) NSString *timeOfDay;
@property (nonatomic, strong) NSString *mealTiming;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *comments;

-(void) saveDiabetesLogWithGlucose:(NSString *)glucose insulin:(NSString *)insulin a1c:(NSString *)a1c timeOfDay:(NSString *)timeOfDay mealTiming:(NSString *)mealTiming timestamp:(NSString *)timestamp comments:(NSString *)comments;
@end
