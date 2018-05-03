//
//  StopsTableVC.m
//  DeCampV3
//
//  Created by James Baker on 2/10/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import "StopsTableVC.h"

@interface StopsTableVC () 

@end

@implementation StopsTableVC




- (void)InitBusDictionaries
{
    NSLog(@"Entering StopsTableVC::InitBusDictionaries");
    BusDict = [NSMutableDictionary dictionaryWithCapacity:1];
    
    //Load the bus dictionary
    NSString *tempLastBusNum = @"1";
    NSMutableString *BusStopsString = [NSMutableString stringWithCapacity:1];
    
    //$$TODO$$ could probally do all this in a nsarray from the begining as the value of the nsdictionary instead of using a string and then moving that string into an array and then placing in a nsdictionary
    //Find the buss lists
    for(int i=0;i<tblStopData.count;i++)
    {
        //Check to see if the current bus is the same as the last bus in the loop so we can see if we should create a new key or use last key and concatinate the string
        if(![tempLastBusNum isEqualToString:tblStopData[i][1]])
        {
            //Load the comma delimited string BusStopString into a string Array so it will store in the dictionary and be dequeued properly
            stringArrayBusStop = [BusStopsString componentsSeparatedByString: @","];
            //place the key (which is the bus number, and the string array with the stops in the object dictionary
            [BusDict setObject:stringArrayBusStop forKey:tempLastBusNum];
            //change the string that has all the comma delimited bus stops to hold the new bus stop from the new bus
            [BusStopsString setString:tblStopData[i][0]];
        }
        else  //else build out the string
        {
            //if there is already a bus stop in the string then place a comma in there
            if(![BusStopsString isEqualToString:@""])
            {
                [BusStopsString appendString:@","]; //place the comma in the string
            }
            //place the bus stop in the string
            [BusStopsString appendString:tblStopData[i][0]];
        }
        
        //Set the last bus remembered to the current bus number
        tempLastBusNum = tblStopData[i][1];
    }
    //do the set of the final bus stop string into an array since we finished building it in the loop
    stringArrayBusStop = [BusStopsString componentsSeparatedByString: @","];
    //add the string array of the bus stops as well as the key into the array
    [BusDict setObject:stringArrayBusStop forKey:tempLastBusNum];
    NSLog(@"Exiting StopsTableVC::InitBusDictionaries");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Entering StopsTableVC::viewDidLoad");


    //allow the table view to hae autosized rows
    [self.tableView sizeToFit];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Init the dictionaries of buses if the data is not current location but a selected location
    [self InitBusDictionaries];
    
    
    busSectionTitles = [[BusDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@"Exiting StopsTableVC::viewDidLoad");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Entering StopsTableVC::numberOfSectionsInTableView");
    NSLog(@"Exiting StopsTableVC::numberOfSectionsInTableView");

    return BusDict.count;
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entering tableView::didSelectRowAtIndexPath sub class of StopsTable::");

    if(![self->tblStopData[indexPath.row][0] isEqual:nil])
    {
        NSString *sectionTitle = [busSectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionBus = [BusDict objectForKey:sectionTitle];
        NSString *bus = [sectionBus objectAtIndex:indexPath.row];
        self->tblFromSectionName = bus;//tblStopData[indexPath.row][0];
        [self performSegueWithIdentifier:@"busSelected" sender:self];
    }
    NSLog(@"Exiting tableView::didSelectRowAtIndexPath sub class of StopsTable::");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Entering tableView::numberOfRowsInSection sub class of StopsTable::");

    // Return the number of rows in the section.
    NSString *sectionTitle = [busSectionTitles objectAtIndex:section];
    NSArray *sectionBus = [BusDict objectForKey:sectionTitle];
    
    NSLog(@"Exiting tableView::numberOfRowsInSection sub class of StopsTable::");
    return [sectionBus count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSLog(@"Entering tableView::titleForHeaderInSection sub class of StopsTable::");
    NSLog(@"Entering tableView::titleForHeaderInSection sub class of StopsTable::");

    return [busSectionTitles objectAtIndex:section];
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Entering tableView::cellForRowAtIndexPath sub class of StopsTable::");

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stopCells" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    NSString *sectionTitle = [busSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionBus = [BusDict objectForKey:sectionTitle];
    NSString *bus = [sectionBus objectAtIndex:indexPath.row];
    cell.textLabel.text = bus;
    cell.imageView.image = [UIImage imageNamed:@"new_decamp_bus.jpeg"];
    
    NSLog(@"Exiting tableView::cellForRowAtIndexPath sub class of StopsTable::");

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
