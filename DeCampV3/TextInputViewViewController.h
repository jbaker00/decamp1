//
//  TextInputViewViewController.h
//  DeCampV3
//
//  Created by Baker, James on 11/29/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputViewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *DayType;

-(NSMutableArray*)loadStopsFromFile:(NSString*)fileName;
-(NSMutableArray*)loadStopIndexFromFile:(NSString*)fileName; //add a 2nd value of an array name


//- (void)placeTextBorder:(UITextField*)textField;

@property (weak, nonatomic) IBOutlet UIButton *btnFromField;
@property (weak, nonatomic) IBOutlet UIButton *btnToField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segWeekend;

@property (weak, nonatomic) IBOutlet UIDatePicker *departureTime;
@property (nonatomic, assign) BOOL from;
@end
