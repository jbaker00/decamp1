//
//  ScheduleViewController.h
//  NYCBusScheduler
//
//  Created by James Baker on 4/17/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ScheduleViewController : UIViewController
{
    //Array of bus stops
    @public NSArray *tblFromData;
    
    //Source Name of the bus selected
    @public  NSString *tblFromSectionName;
    
    //Destination
    @public NSString *strDestination;
    
    //Public version of my location
    @public  CLLocation *locationMe;
    
    //Array of bus stops
    @public NSArray *tblStopData;
    
    //Source Lat/Long
    CLLocationCoordinate2D srcPoint;
    
    //Destination Lat/Long
    CLLocationCoordinate2D destPoint;
    
    //Time of chosen departure
    NSString *strDepartureTime;
    
    NSString *strArrivalTime;
    
    //Dictionary of busses for the array to show section names if current location selected
    NSMutableDictionary *BusDict;
    
    //Section titles
    NSArray *busSectionTitles;
    
    //Bus stops
    NSArray *stringArrayBusStop;
    
    //Bus stops
    NSArray *arrBusStops;
    
    //array of closest stops
    NSMutableArray *closestBusStops;
    
    
    NSInteger nsiWeekend;
    

}

@property (nonatomic, assign) BOOL curLocUsed;

@end
