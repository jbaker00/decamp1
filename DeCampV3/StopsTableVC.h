//
//  StopsTableVC.h
//  DeCampV3
//
//  Created by James Baker on 2/10/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopsTableVC : UITableViewController
{
    //Array of bus stops
    @public NSArray *tblStopData;
    //Name of the bus selected
    @public  NSString *tblFromSectionName;
}

//Name of bus selected in property
//@property (strong, nonatomic) NSString *selectedBus;
@property (nonatomic) bool from;
@end
