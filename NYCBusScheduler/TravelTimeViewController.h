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
    
    //Src Name String
    @public NSString *strSourceName;
    
    //Destination Name String
    @public NSString *strDestName;
}

#pragma Input properties on screen


#pragma Output properties on screen

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *outputStartName;
@property (weak, nonatomic) IBOutlet UILabel *outputExpectedTravelTime;
@property (weak, nonatomic) IBOutlet UILabel *outputDistance;
@property (weak, nonatomic) IBOutlet UILabel *outputArrivalDate;
@property (weak, nonatomic) IBOutlet UILabel *outputEndName;

@end
