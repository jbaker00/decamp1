//
//  ViewController.h
//  DeCampV3
//
//  Created by Baker, James on 10/23/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnTo;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segWeekday;
@property (weak, nonatomic) IBOutlet UIDatePicker *departureTime;

@property (nonatomic, assign) BOOL from;

@end

