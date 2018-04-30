//
//  TravelTimeViewController.m
//  NYCBusScheduler
//
//  Created by James Baker on 4/28/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import "TravelTimeViewController.h"
@import MapKit;
@import CoreLocation;

@interface TravelTimeViewController ()

@end

@implementation TravelTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Entering TravelTimeViewController::viewDidLoad");
    
    //Set the output label for the Start name
    self->_outputStartName.text = strSourceName;
    
    //Set the output label for the End name
    self->_outputEndName.text = strDestName;
    
    //set the center of the map to lincoln tunnel
    CLLocationCoordinate2D mapPortAuth = CLLocationCoordinate2DMake(40.760128, -74.003065);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapPortAuth, 6000, 6000);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.showsUserLocation = YES;
    
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

    //find the eta
    [self findBusETA];
    NSLog(@"Exiting TravelTimeViewController::viewDidLoad");
}

-(void)findBusETA  //(CLLocationCoordinate2DIsValid*)source end:(CLLocationCoordinate2DIsValid*)destination
{
    MKPlacemark *placemarkSrc = [[MKPlacemark alloc] initWithCoordinate:self->sourcePoint addressDictionary:nil];
    MKMapItem *mapItemSrc = [[MKMapItem alloc] initWithPlacemark:placemarkSrc];
    MKPlacemark *placemarkDest = [[MKPlacemark alloc] initWithCoordinate:self->destPoint addressDictionary:nil];
    MKMapItem *mapItemDest = [[MKMapItem alloc] initWithPlacemark:placemarkDest];
    [mapItemSrc setName:@"Start Name"];
    [mapItemDest setName:@"Destination Name"];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:mapItemSrc];
    [request setDestination:mapItemDest];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    //convert stored time to military time
    //put current date and specified tie into a NSDate
    //set the departure time
    //[request setDepartureDate:<#(NSDate * _Nullable)#>]
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateETAWithCompletionHandler:
     ^(MKETAResponse *response, NSError *error) {
         if (error) {
             // Handle Error
             NSLog(@"Erroroed out the calculateETAWithCompletionHandler with error code %ldd and userInfo %@",(long)error.code, error.userInfo);
         } else {
            //Output the Departure Date
             NSDate *busExpectedDepartureDate = response.expectedDepartureDate;
             NSString *formattedDepartDateString = [NSDateFormatter localizedStringFromDate: busExpectedDepartureDate dateStyle: NSDateFormatterNoStyle timeStyle: NSDateFormatterShortStyle];
             NSLog(@"The expected Departure time is %@", formattedDepartDateString);
             
             //Output the ExpectedTravelTime
             NSTimeInterval busExpectedTravelTime = response.expectedTravelTime;
             NSInteger busTravelTimeInt = [[NSString stringWithFormat:@"%f", busExpectedTravelTime] integerValue];
             busTravelTimeInt = busTravelTimeInt / 60;
             self->_outputExpectedTravelTime.text = [NSString stringWithFormat:@"%li", (long)busTravelTimeInt];
             NSLog(@"The expected Travel time is %f seconds", busExpectedTravelTime);
             NSLog(@"The expected Travel time is %@ minutes",  self->_outputExpectedTravelTime.text);

             //Output the ExpectedArrival Date
             NSDate *busExpectedArrivalDate = response.expectedArrivalDate;
             NSString *formattedArrivalDateString = [NSDateFormatter localizedStringFromDate: busExpectedArrivalDate dateStyle: NSDateFormatterNoStyle timeStyle: NSDateFormatterShortStyle];
             NSLog(@"The expected Arrival date is %@", formattedArrivalDateString);
             self->_outputArrivalDate.text = formattedArrivalDateString;
             
             //Output the travel distance
             CLLocationDistance busDistance = response.distance;
             NSInteger busTravelDistance = [[NSString stringWithFormat:@"%f", busDistance] integerValue];
             busTravelDistance = busTravelDistance * 0.000621371;
             self->_outputDistance.text = [NSString stringWithFormat:@"%li", (long)busTravelDistance];
             NSLog(@"The travel distance is %f meters", busDistance);
             NSLog(@"The travel distance is %@ miles", self->_outputDistance.text);

             //Output the Transportation Type
             MKDirectionsTransportType busTransportType = response.transportType;
             NSLog(@"The Transportatoin type is %lu", (unsigned long)busTransportType);
             //MKDirectionsTransportTypeAutomobile
             //MKDirectionsTransportTypeWalking
             //MKDirectionsTransportTypeTransit
             //MKDirectionsTransportTypeAny
             
         }
     }];

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
