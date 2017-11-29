//
//  ViewController.h
//  DeCampV3
//
//  Created by Baker, James on 10/23/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *lblOutput;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segBus;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segRoute;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segWeek;




- (IBAction)segBusTapped:(id)sender;
- (IBAction)segRouteTapped:(id)sender;
- (IBAction)segTimeTapped:(id)sender;
- (IBAction)segWeekTapped:(id)sender;



@end

