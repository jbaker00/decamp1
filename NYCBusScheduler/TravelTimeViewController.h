//
//  TravelTimeViewController.h
//  NYCBusScheduler
//
//  Created by James Baker on 4/28/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@import CoreLocation;

@interface TravelTimeViewController : UIViewController
{
    //Src
    @public CLLocationCoordinate2D sourcePoint;
    
    //Dest
    @public CLLocationCoordinate2D destPoint;
    
    //Departure Date/Time
    @public NSString *strDepartureTime;
}

#pragma Input properties on screen


#pragma Output properties on screen

@property (weak, nonatomic) IBOutlet UILabel *outputExpectedDepartureDate;
@property (weak, nonatomic) IBOutlet UILabel *outputExpectedTravelTime;
@property (weak, nonatomic) IBOutlet UILabel *outputDistance;
@property (weak, nonatomic) IBOutlet UILabel *outputTransportationType;

@end
