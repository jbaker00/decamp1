//
//  ViewController.h
//  DeCampV3
//
//  Created by Baker, James on 10/23/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Mapkit/Mapkit.h>


@interface ViewController : UIViewController  <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *locationMe;
    CLGeocoder *geocoder;
    NSString *strMyLoc;
}

@property (weak, nonatomic) IBOutlet UIButton *btnFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnTo;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segWeekday;
@property (weak, nonatomic) IBOutlet UIDatePicker *departureTime;

@property (nonatomic, assign) BOOL from;
@property (nonatomic, assign) BOOL curLocUsed;

@property (assign, nonatomic) UIInterfaceOrientation lastOrientation;


@end

