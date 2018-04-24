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
    
    //Name of the bus selected
    @public  NSString *tblFromSectionName;
    
    //Public version of my location
    @public  CLLocation *locationMe;
    
    //Array of bus stops
    @public NSArray *tblStopData;
    
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
    
    NSString *strDestination;
    
    NSInteger nsiWeekend;
    

}

@property (nonatomic, assign) BOOL curLocUsed;

@end
