//
//  TableViewControllerFromSelect.h
//  DeCampV3
//
//  Created by James Baker on 12/26/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewControllerFromSelect : TableViewController
{
    //Array of bus stops
    @public NSArray *tblFromData;
    //Name of the bus selected
    @public  NSString *tblFromSectionName;
}
//Name of bus selected in property
//@property (strong, nonatomic) NSString *selectedBus;
@property (nonatomic) bool from;


@end
