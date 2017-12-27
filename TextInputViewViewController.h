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

- (IBAction)FindBus:(id)sender;
//- (void)placeTextBorder:(UITextField*)textField;

@property (weak, nonatomic) IBOutlet UIButton *btnFromField;
@property (weak, nonatomic) IBOutlet UIButton *btnToField;

@property (weak, nonatomic) IBOutlet UIDatePicker *departureTime;
@end
