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
        if([sectionTitle isEqualToString:@"NA"])
        {
            return 1;
        }
        else
        {
            return [sectionBus count];
        }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entering scheduleTableVC::cellForRowAtIndexPath");

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSchedule" forIndexPath:indexPath];

    if(self.curLocUsed == YES)
    {
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        NSString *sectionTitle = [busSectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionBus = [BusDict objectForKey:sectionTitle];
        NSString *bus = [sectionBus objectAtIndex:indexPath.row];
        //NSString *bus = sectionBus[indexPath.row];
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

         //start the loop of the srcBusList looking for the distane between it and current location
         for(int i=0;i<tblStopData.count;i++)
         {
             if(![tblStopData[i][0]  isEqual: @"NYC_P/A Bus Terminal"])
             {
                 //get the  annotation lat and log into a CLocation
                 CLLocation *stopLoc = [[CLLocation alloc] initWithLatitude:[tblStopData[i][2] doubleValue] longitude:[tblStopData[i][3] doubleValue]];
         
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

    //Initilize the Bus Dictionary so that we can use it for the filling out of the Output table
    BusDict = [NSMutableDictionary dictionaryWithCapacity:1];
    
    //This is the temp variable that we will use to evaluate new sections needed
    NSString *tempLastBusNum;// = @"1 NA";
    
     //Find the buss lists
    for(int i=0;i<closestBusStops.count;i++)
    {
        //Check to see if the current bus is the same as the last bus in the loop so we can see if we should create a new key or use last key and concatinate the string
        if(![tempLastBusNum isEqualToString:closestBusStops[i][0]])
        {
            //we need to set the tempLastBusNum to the first bus if its set to "" since its the first time in the loop, we cant do a fwd load of the array or else it will not enter into this loop
            tempLastBusNum = closestBusStops[i][0];
            
            //Load the comma delimited string BusStopString into a string Array so it will store in the dictionary and be dequeued properly
            arrBusStops = [self findStopTimesAtStart:closestBusStops[i][0]];
    
            //place the key (which is the bus number, and the string array with the stops in the object dictionary
            [BusDict setObject:arrBusStops forKey:tempLastBusNum];
        }
    }
    
    if(!tempLastBusNum)
    {
        //No busses so set the no busses string
        tempLastBusNum = @"None";
        //do it this way so we pass variables to the dictionary set object and we get a nsArray and do not crash when we get to numberofrowsinsection function
        NSMutableString *BusStopString = [[NSMutableString alloc] init];
        [BusStopString setString:@"No Busses within .5 miles of your current location"];
        
        //alloc the bus dictionary
        NSMutableArray *BusStopsArray = [[NSMutableArray alloc] init];;
        
        //add our output to the dict
        [BusStopsArray addObject:BusStopString];
        
        //add the no busses to output array
        [BusDict setObject:BusStopsArray forKey:@"NA"];

        //stringArrayBusStop = [BusStopsString componentsSeparatedByString: @","];
    }


    NSLog(@"Exiting scheduleTableVC::InitBusDictionaries");
}


//method to look up the times given the stop name
- (NSArray*)findStopTimesAtStart:(NSString*)strStart
{
    NSLog(@"Entering scheduleTableVC::findStopTimesAtStop");
    //strStart = start location
    //strDestination = stop location
    
    NSArray *builderArray;
    
    //Take the bus number and build out the file name that we need to load
    //Lookup Bus Number
    
    //get the bus number take the strStart and just the text from begining of file till the first space
    NSArray *arrBusNum = [strStart componentsSeparatedByString:@" "];
    NSLog(@"The bus number is %@", arrBusNum[0]);
    
    //Build out the file name to use to look up the bus info
    //Get the file name of the bus schedule
    NSString *fileNameBody = [self getBusScheduleFileName:arrBusNum[0] fromLocation:strStart];
    NSLog(@"The file name of the bus schedule is %@", fileNameBody);
    
    //Load the file of the bus schedule
    NSMutableArray *busArray = [self loadStopsFromFile:fileNameBody];
    NSLog(@"Array containg the bus schedule for the route %@ bus is %@", arrBusNum[0], busArray);
    
    //Get the file name of the bus stop index file
    NSString *fileStopIndexNameBody = [self getBusStopIndexFileName:arrBusNum[0] fromLocation:strStart];
    NSLog(@"The file name of the bus stop index is %@", fileStopIndexNameBody);
    
    //Get the from(aka. start) stop index in the file
    int iBusStart = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:strStart];
    NSLog(@"Starting bus stop index is %i", iBusStart);
    
    //Get the to(aka. destination) stop index in the file
    int iBusStop = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:strDestination];
    NSLog(@"Stopping bus stop index is %i", iBusStop);
    
    //loop through the new array looking for all line numbers that have _btnFromField.titleLabel.text in it and place those lines into a new array
    builderArray = [self findStops:busArray iBusStart:iBusStart iBusStop:iBusStop];
    
    NSLog(@"Exiting scheduleTableVC::findStopTimesAtStop");
    
    return builderArray;
}

-(NSMutableArray*)loadStopsFromFile:(NSString*)fileName
{
    NSLog(@"Entering scheduleTableVC::loadStopsFromFile");
    
    //Load the file of the fileName
    //Set the error Variable to NIL that we will check later
    NSError *error = nil;
    //Setup the bundle so we can read the file
    NSBundle *main =[NSBundle mainBundle];
    //Setup the file name in the bundlle
    NSString *path = [main pathForResource:fileName ofType:@"txt"];
    //Load the file contents into a string
    NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    //Check for the error code to see if the file read worked
    if(nil != error)
    {
        NSLog(@"Error Resding URL with error %@", error.localizedDescription);
    }
    
    
    //Look at the contents of the file loaded into the string and parse it for the columns per row
    //Set the row seperator
    NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
    
    //counters
    int iRow = 0;
    int iColumn = 0;
    
    
    //MainArray
    NSMutableArray *rowArray = [NSMutableArray array];
    
    for (NSString *row in rows){
        {
            if(![row isEqualToString:@""])
            {
                //NSLog(@"Starting off row %i with contents %@", iRow, row);
                iRow++; //increent the row counter
                iColumn = 0;
                NSMutableArray *columnArray = [NSMutableArray array];
                
                NSArray* columns = [row componentsSeparatedByString:@","];
                for(NSString *column in columns)
                {
                    //NSLog(@"Adding information to column %i with information %@", iColumn, column);
                    iColumn++; //increment the column counter
                    [columnArray addObject:column];
                }
                
                [rowArray addObject:columnArray];
            }
            else
            {
                //NSLog(@"We found a blank line");
            }
        }
        //NSLog(@"Filled in one row in the table with %i rows and %i columns", iRow, iColumn);
    }
    //NSLog(@"Filled in all rows in the table");
    
    NSLog(@"Exiting scheduleTableVC::loadStopsFromFile");
    
    return rowArray;
}

- (NSArray *)findStops:(NSMutableArray *)busArray iBusStart:(int)iBusStart iBusStop:(int)iBusStop
{
    NSLog(@"Entering scheduleTableVC::findStops");
    
    //NSMutableString *returnString = [NSMutableString stringWithCapacity:1];
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    NSMutableString *stringBuilder = [NSMutableString stringWithCapacity:1];
    for(int i=0; i<busArray.count; i++)
    {
        //check the index that fits for the specific stop
        if(![busArray[i][iBusStart] isEqualToString:@""])
        {
            if(![busArray[i][iBusStop] isEqualToString:@""])
            {
                //NSLog(@"Starting stop name is %@", _btnFrom.titleLabel.text);
                NSLog(@"Index of the starting stop name in the array is %i", iBusStart);
                NSLog(@"Starting stop time is %@", busArray[i][iBusStart]);
                //NSLog(@"Stopping stop name is %@", _btnTo.titleLabel.text);
                NSLog(@"Index of the stopping stop name in the array is %i", iBusStop);
                NSLog(@"Stopping stop time is %@",busArray[i][iBusStop]);
                
                //Take the row info and place it in one string
                [stringBuilder appendString:busArray[i][iBusStart]];
                [stringBuilder appendString:@" - "];
                [stringBuilder appendString:busArray[i][iBusStop]];
                NSLog(@"The output for the table will be %@", stringBuilder);
                
                //add the string to the array
                [stringArray addObject:stringBuilder];
                
                //Add a delimiter to the output string
                //[returnString stringByAppendingString:@","];
                //Add the string to an output string
                //[returnString stringByAppendingString:stringBody];
                
                //clear out string for next placement in of new string
                stringBuilder = [NSMutableString stringWithString:@""];
            }
        }
        
    }
    if(!stringArray)
    {
        //Add the string to an output array
        //[stringBody stringByAppendingString:@"No Bus Schedule Available for Route"];
        [stringArray addObject:@"No Bus Schedule Available for Route"];
    }

    NSLog(@"Entering scheduleTableVC::findStops");
    return stringArray;
}


//Function to load strings into an array from a file
-(int)loadStopIndexFromFile:(NSString*)fileName busStopName:(NSString*)stopName//add a 2nd value of an array name
{
    NSLog(@"Entering scheduleTableVC::loadStopIndexFromFile");
    
    //Set the error Variable to NIL that we will check later
    NSError *error = nil;
    //Setup the bundle so we can read the file
    NSBundle *main =[NSBundle mainBundle];
    //Setup the file name in the bundlle
    NSString *path = [main pathForResource:fileName ofType:@"txt"];
    //Load the file contents into a string
    NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    //Check for the error code to see if the file read worked
    if(nil != error)
    {
        NSLog(@"Error Resding URL with error %@", error.localizedDescription);
    }
    
    //Look at the contents of the file loaded into the string and parse it for the columns per row
    //Set the row seperator
    NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
    
    int i = 0; //counter for the string array
    
    for (NSString *row in rows)
    {
        if([row isEqualToString:stopName])
        {
            NSLog(@"Exiting ViewController::loadStopIndexFromFile");
            return i;
        }
        i++;
    }
    NSLog(@"Exiting scheduleTableVC::loadStopIndexFromFile");
    return(0);
}

- (NSString *)getBusStopIndexFileName:(NSString *)strBusNumber fromLocation:(NSString*)fromStop
{
    NSLog(@"Entering scheduleTableVC::getBusStopIndexFileName");
    
    NSMutableString *fileNameBody; //string to store the file name
    
    fileNameBody = [NSMutableString stringWithCapacity:1];
    
    [fileNameBody appendString:strBusNumber];//append the bus number
    
    //append to or from NYC
    if([fromStop isEqualToString:@"NYC_P/A Bus Terminal"])
    {
        [fileNameBody appendString:@"fromNYC"]; //append the to for from NYC
    }
    else
    {
        [fileNameBody appendString:@"toNYC"]; //append the to for from NYC
    }
    NSString *returnString = [fileNameBody stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"Exiting scheduleTableVC::getBusStopIndexFileName");
    return returnString;
}

- (NSString *)getBusScheduleFileName:(NSString *)strBusNumber fromLocation:(NSString*)fromStop{
    NSLog(@"Entering scheduleTableVC::getBusScheduleFileName");
    
    
    NSMutableString *fileNameBody; //string to store the file name
    
    fileNameBody = [NSMutableString stringWithCapacity:1];
    
    [fileNameBody appendString:strBusNumber];//append the bus number
    
    //append to or from NYC
    if([fromStop isEqualToString:@"NYC_P/A Bus Terminal"])
    {
        [fileNameBody appendString:@"fromNYC"]; //append the to for from NYC
    }
    else
    {
        [fileNameBody appendString:@"toNYC"]; //append the to for from NYC
    }
    
    //append the weekday or weekend to the string
    if(nsiWeekend == 0)
    {
        [fileNameBody appendString:@"Weekdays"];
    }
    else
    {
        [fileNameBody appendString:@"Weekend"];
    }
    NSString *returnString = [fileNameBody stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"Exiting scheduleTableVC::getBusScheduleFileName");
    return returnString;
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
