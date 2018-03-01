//
//  scheduleTableVC.h
//  DeCampV3
//
//  Created by James Baker on 2/9/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scheduleTableVC : UITableViewController
{
    //Array of bus stops
    @public NSArray *tblFromData;
    //Name of the bus selected
    @public  NSString *tblFromSectionName;

}
@end
