//
//  TravelTimeViewController.m
//  NYCBusScheduler
//
//  Created by James Baker on 4/28/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import "TravelTimeViewController.h"

@interface TravelTimeViewController ()

@end

@implementation TravelTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Entering TravelTimeViewController::viewDidLoad");
    
    //make sure we have a valid source point first before pusing it out to a log of the output
    if(CLLocationCoordinate2DIsValid(sourcePoint))
    {
        NSLog(@"Source location Latitude is %f", self->sourcePoint.latitude);
        NSLog(@"Source location Longitude is %f", self->sourcePoint.longitude);
    }
    
    //make sure we have a valid desitnation point first before pusing it out to a log of the output
    if(CLLocationCoordinate2DIsValid(destPoint))
    {
        NSLog(@"Destination location Latitude is %f", self->destPoint.latitude);
        NSLog(@"Destination location Longitude is %f", self->destPoint.longitude);
    }
    
    //log out the departure time
    NSLog(@"Departure time is %@", strDepartureTime);

    
    NSLog(@"Exiting TravelTimeViewController::viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
