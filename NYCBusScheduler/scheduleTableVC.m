//
//  scheduleTableVC.m
//  DeCampV3
//
//  Created by James Baker on 2/9/18.
//  Copyright © 2018 Baker, James. All rights reserved.
//

#import "scheduleTableVC.h"

@interface scheduleTableVC ()

@end

@implementation scheduleTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Entering scheduleTableVC::viewDidLoad");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Init the dictionaries of buses if the data is not current location but a selected location
    //[self InitBusDictionaries:tblStopData];
    
    
    //Init the dictionaries of buus if the data is from a current location selection
    if(self.curLocUsed == YES)
    {
        //Find the closest stops
        [self findCloseStops:locationMe];
        //setup the bus dictionary with the closes stops within the 1 mile radius
        [self InitBusDictionaries];
        //setup the section title names
        busSectionTitles = [[BusDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    NSLog(@"Exiting scheduleTableVC::viewDidLoad");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

    [self performSegueWithIdentifier:@"showStopMap" sender:self];
*/
    NSLog(@"Entering scheduleTableVC::didSelectRowAtIndexPath");

    NSLog(@"Selected a row in the table");
    NSLog(@"Exiting scheduleTableVC::didSelectRowAtIndexPath");

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Entering scheduleTableVC::numberOfSectionsInTableView");

    if(self.curLocUsed == YES)
    {
        NSLog(@"Exiting scheduleTableVC::numberOfSectionsInTableView");
        return BusDict.count;
    }
    else
    {
        NSLog(@"Exiting scheduleTableVC::numberOfSectionsInTableView");
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Entering scheduleTableVC::numberOfRowsInSection");
    if(self.curLocUsed == YES)
    {
        // Return the number of rows in the section.
        NSString *sectionTitle = [busSectionTitles objectAtIndex:section];
        NSArray *sectionBus = [BusDict objectForKey:sectionTitle];
        NSLog(@"Exiting scheduleTableVC::numberOfRowsInSection");
        return [sectionBus count];
    }
    else
    {
        NSLog(@"Exiting scheduleTableVC::numberOfRowsInSection");
        return tblFromData.count;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"Entering scheduleTableVC::titleForHeaderInSection");

    if(self.curLocUsed == YES)
    {
        NSLog(@"Exiting scheduleTableVC::titleForHeaderInSection");
        return [busSectionTitles objectAtIndex:section];
    }
    else
    {
        NSLog(@"Exiting scheduleTableVC::titleForHeaderInSection");
        return tblFromSectionName;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSchedule" forIndexPath:indexPath];
    
    NSLog(@"Entering scheduleTableVC::cellForRowAtIndexPath");

    if(self.curLocUsed == YES)
    {
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        NSString *sectionTitle = [busSectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionBus = [BusDict objectForKey:sectionTitle];
        NSString *bus = [sectionBus objectAtIndex:indexPath.row];
        cell.textLabel.text = bus;
        cell.imageView.image = [UIImage imageNamed:@"new_decamp_bus.jpeg"];
    }
    else
    {
        // Configure the cell...
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = tblFromData[indexPath.row];//[0];
        cell.imageView.image = [UIImage imageNamed:@"bus-32.png"];
    }
    NSLog(@"Exiting scheduleTableVC::cellForRowAtIndexPath");

    return cell;
}
-(void)findCloseStops:(CLLocation *)location
 {
     NSLog(@"Entering scheduleTableVC::findCloseStops");
     if(tblStopData != nil)         //ensure the srcbusList(we only support the src spot for cur location) is loaded from viewDid Load
     {
         //Create an array of CLLocation items that will store the closest stops
         closestBusStops = [[NSMutableArray alloc] init];
         //CLLocation *stopLoc = [[CLLocation alloc]init];
         //start the loop of the srcBusList looking for the distane between it and current location
         for(int i=0;i<tblStopData.count;i++)
         {
             if(![tblStopData[i][0]  isEqual: @"NYC_P/A Bus Terminal"])
             {
                 //NSLog(@"Log locaiton from file is %f",[tblStopData[i][2] doubleValue]);
                 //NSLog(@"Lat location from file is %f",[tblStopData[i][3] doubleValue]);
                 //get the  annotation lat and log into a CLocation
                 CLLocation *stopLoc = [[CLLocation alloc] initWithLatitude:[tblStopData[i][2] doubleValue] longitude:[tblStopData[i][3] doubleValue]];
                 //stopLoc.coordinate.latitude = [tblStopData[i][2] doubleValue];
                 //stopLoc.cordiante.longitude = [tblStopData[i][3]doubleValue]];
                 
                 //Get the distance between current locaiton and the annotation location
                 CLLocationDistance distance = [locationMe distanceFromLocation:stopLoc];
                 
                 //Check to see if the stop is 1/2 mile 804 meters away from current location and if it is add it to the close bus stop array
                 if(distance <804)
                 {
                     //Add object to our closestBusStops array
                     NSLog(@"A bus stop was found within 804 meters 1/2 mile its distance away is %f the stop name is %@", distance, tblStopData[i][0]);
                     [closestBusStops addObject:tblStopData[i]];
                 }
             }
         }
         
         //time to build the output table and the section headers with a nie loop of the cloestBusStops Array.
         if(!closestBusStops)
         {
            //No close bus stops put no close buses within .25 mile in here
            NSLog(@"No close bus stops put no close buses within ..5 mile in here");
             [closestBusStops addObject:@"No Buses available for your current location"];
         }

     }
     NSLog(@"Exiting scheduleTableVC::findCloseStops");

}

- (void)InitBusDictionaries
{
    NSLog(@"Entering scheduleTableVC::InitBusDictionaries");

    BusDict = [NSMutableDictionary dictionaryWithCapacity:1];
    

    NSString *tempLastBusNum;// = @"1 NA";
    //Load the bus dictionary
    NSMutableString *BusStopsString = [NSMutableString stringWithCapacity:1];
    
    //$$TODO$$ could probally do all this in a nsarray from the begining as the value of the nsdictionary instead of using a string and then moving that string into an array and then placing in a nsdictionary
    //Find the buss lists
    for(int i=0;i<closestBusStops.count;i++)
    {
        //Set the last bus remembered to the current bus number
        //tempLastBusNum = closestBusStops[i][1];
        
        //Check to see if the current bus is the same as the last bus in the loop so we can see if we should create a new key or use last key and concatinate the string
        if(![tempLastBusNum isEqualToString:closestBusStops[i][1]])
        {
            //we need to set the tempLastBusNum to the first bus if its set to "" since its the first time in the loop, we cant do a fwd load of the array or else it will not enter into this loop
            if(!tempLastBusNum)
                tempLastBusNum = closestBusStops[i][1];
            
            //Load the comma delimited string BusStopString into a string Array so it will store in the dictionary and be dequeued properly
            stringArrayBusStop = [BusStopsString componentsSeparatedByString: @","];
            //place the key (which is the bus number, and the string array with the stops in the object dictionary
            [BusDict setObject:stringArrayBusStop forKey:tempLastBusNum];
            //change the string that has all the comma delimited bus stops to hold the new bus stop from the new bus
            [BusStopsString setString:closestBusStops[i][0]];
        }
        else  //else build out the string
        {
            //if there is already a bus stop in the string then place a comma in there
            if(![BusStopsString isEqualToString:@""])
            {
                [BusStopsString appendString:@","]; //place the comma in the string
            }
            //place the bus stop in the string
            [BusStopsString appendString:closestBusStops[i][0]];
        }
        
        //Set the last bus remembered to the current bus number
        tempLastBusNum = closestBusStops[i][1];
    }
    
    //Try and remove the 1 NA section header from the dictionary
   // [BusDict removeObjectForKey:@"1 NA"];

    
    //do the set of the final bus stop string into an array since we finished building it in the loop
    stringArrayBusStop = [BusStopsString componentsSeparatedByString: @","];
    //add the string array of the bus stops as well as the key into the array
    [BusDict setObject:stringArrayBusStop forKey:tempLastBusNum];

    NSLog(@"Exiting scheduleTableVC::InitBusDictionaries");
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
