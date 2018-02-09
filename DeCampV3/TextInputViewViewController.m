//
//  TextInputViewViewController.m
//  DeCampV3
//
//  Created by Baker, James on 11/29/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "TextInputViewViewController.h"
#import "TableViewControllerFromSelect.h"
#import "TableViewControllerBusList.h"

@interface TextInputViewViewController ()
@end

@implementation TextInputViewViewController
NSMutableArray *tblFromSelection;
NSMutableArray *outputArray;
NSString *stringTitle;
NSString *busRoutes;


//- (NSMutableArray*)getBusStops:(NSString*)busStop forTime:(NSSTimeInterval*)timeInterval;
//Function to load strings into an array from a file
-(int)loadStopIndexFromFile:(NSString*)fileName busStopName:(NSString*)stopName//add a 2nd value of an array name
{
    
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
            return i;
        }
        i++;
    }
    return(0);
}

-(NSMutableArray*)loadStopsFromFile:(NSString*)fileName
{
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
                NSLog(@"Starting off row %i with contents %@", iRow, row);
                iRow++; //increent the row counter
                iColumn = 0;
                NSMutableArray *columnArray = [NSMutableArray array];
                
                NSArray* columns = [row componentsSeparatedByString:@","];
                for(NSString *column in columns)
                {
                    NSLog(@"Adding information to column %i with information %@", iColumn, column);
                    iColumn++; //increment the column counter
                    [columnArray addObject:column];
                }
                
                [rowArray addObject:columnArray];
            }
            else
            {
                NSLog(@"We found a blank line");
            }
        }
        NSLog(@"Filled in one row in the table with %i rows and %i columns", iRow, iColumn);
    }
    NSLog(@"Filled in all rows in the table");
    return rowArray;
}


- (NSString*)fillTableHeader:(NSString *)strBusNumber {
    NSMutableString *stringTitle = [NSMutableString stringWithString:strBusNumber];
    [stringTitle appendString:@" Bus "];
    [stringTitle appendString:_btnFromField.titleLabel.text];
    [stringTitle appendString:@" to "];
    [stringTitle appendString:_btnToField.titleLabel.text];
    NSLog(@"The string of the title is %@", stringTitle);
    return stringTitle;
}

- (NSString *)loadBusNumber:(NSString *)startStop destStop:(NSString *)destStop{
    NSString *strBusNumber;// = @"33"; //hard coded to fake things out
    
    //Load the bus array of busses and stops
    NSLog(@"loading the bus stop list and bus numbers into an array");
    NSMutableArray *busNumArray = [self loadStopsFromFile:@"BusListNew"];

    
    //check the start Stop to see if it's NYP if so then use the destination to look up the bus based on that stop
    if(![startStop isEqualToString:@"NYC_P/A Bus Terminal"])
    {
        //Look up bus number based off the startStop
        for(int i=0; i<busNumArray.count;i++)
        {
            if([busNumArray[i][0] isEqualToString:startStop])
            {
                strBusNumber = busNumArray[i][1];
            }
        }
    }
    else
    {
        //Look up the bus number based off the destStop
        for(int i=0; i<busNumArray.count;i++)
        {
            if([busNumArray[i][0] isEqualToString:destStop])
            {
                strBusNumber = busNumArray[1];
            }
        }
    }
    return strBusNumber;
}

- (void)printDebugInfo:(NSString *)strBusNumber {
    NSLog(@"from location is, %@",_btnFromField.titleLabel.text);
    NSLog(@"to location is , %@", _btnToField.titleLabel.text);
    NSLog(@"weekend is set to, , %i", _segWeekend.selected);
    NSLog(@"time of day is set to, %@", _departureTime.date);
    NSLog(@"Bus number is %@", strBusNumber);
}

- (void)findStops:(NSMutableArray *)busArray iBusStart:(int)iBusStart iBusStop:(int)iBusStop stringBody:(NSMutableString **)stringBody {
    for(int i=0; i<busArray.count; i++)
    {
        //check the index that fits for the specific stop
        if(![busArray[i][iBusStart] isEqualToString:@""])
        {
            NSLog(@"Starting stop name is %@", _btnFromField.titleLabel.text);
            NSLog(@"Index of the starting stop name in the array is %i", iBusStart);
            NSLog(@"Starting stop time is %@", busArray[i][iBusStart]);
            NSLog(@"Stopping stop name is %@", _btnToField.titleLabel.text);
            NSLog(@"Index of the stopping stop name in the array is %i", iBusStop);
            NSLog(@"Stopping stop time is %@",busArray[i][iBusStop]);
            
            //Take the row info and place it in one string
            [*stringBody appendString:busArray[i][iBusStart]];
            [*stringBody appendString:@" - "];
            [*stringBody appendString:busArray[i][iBusStop]];
            NSLog(@"The output for the table will be %@", *stringBody);
            
            //Add the string to an output array
            [outputArray addObject:*stringBody];
            
            //clear out string for next placement in of new string
            *stringBody = [NSMutableString stringWithString:@""];
        }
        
    }
}

- (NSMutableString *)getBusScheduleFileName:(NSString *)strBusNumber {
    NSMutableString *fileNameBody; //string to store the file name
    
    fileNameBody = [NSMutableString stringWithCapacity:1];
    
    [fileNameBody appendString:strBusNumber];//append the bus number
    
    //append to or from NYC
    if([_btnFromField.titleLabel.text isEqualToString:@"NYC P/A Bus Terminal"])
    {
        [fileNameBody appendString:@"fromNYC"]; //append the to for from NYC
    }
    else
    {
        [fileNameBody appendString:@"toNYC"]; //append the to for from NYC
    }
    
    //append the weekday or weekend to the string
    if(_segWeekend.selectedSegmentIndex == 0)
    {
        [fileNameBody appendString:@"Weekdays"];
    }
    else
    {
        [fileNameBody appendString:@"Weekend"];
    }
    return fileNameBody;
}

- (NSMutableString *)getBusStopIndexFileName:(NSString *)strBusNumber {
    NSMutableString *fileNameBody; //string to store the file name
    
    fileNameBody = [NSMutableString stringWithCapacity:1];
    
    [fileNameBody appendString:strBusNumber];//append the bus number
    
    //append to or from NYC
    if([_btnFromField.titleLabel.text isEqualToString:@"NYC P/A Bus Terminal"])
    {
        [fileNameBody appendString:@"fromNYC"]; //append the to for from NYC
    }
    else
    {
        [fileNameBody appendString:@"toNYC"]; //append the to for from NYC
    }

    return fileNameBody;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segwayShowFromTable"])
    {
        //Grab the view controller
        TableViewControllerFromSelect *controller = [segue destinationViewController];
        
        //set the NSArrary for the table to be filled
        controller->tblFromData = tblFromSelection;
        
        if(self.from == YES)
        {
            controller->tblFromSectionName = @"Orignation";
            [controller setFrom:YES];
        }
        else
        {
            controller->tblFromSectionName = @"Destination";
            [controller setFrom:NO];
        }
    }
    else if ([[segue identifier] isEqualToString:@"showRoutes"])
    {
        //Get the destination view controller
        TableViewControllerBusList *controllerOut = [segue destinationViewController];
        
        //Lookup Bus Number
        NSString * strBusNumber = [self loadBusNumber:_btnFromField.titleLabel.text destStop:_btnToField.titleLabel.text];
        NSLog(@"The Bus number returned fromt the loadBusNumber lookup was %@", strBusNumber);
        
        //Debug info
        [self printDebugInfo:strBusNumber];
        
        //Get the file name of the bus schedule
        NSMutableString *fileNameBody = [self getBusScheduleFileName:strBusNumber];
        NSLog(@"The file name of the bus schedule is %@", fileNameBody);
        
        //Load the file of the bus schedule
        NSMutableArray *busArray = [self loadStopsFromFile:fileNameBody];
        NSLog(@"Array containg the bus schedule for the route %@ bus is %@", strBusNumber, busArray);
        
        //Fill ou the header row
        stringTitle = [self fillTableHeader:strBusNumber];
        NSLog(@"Title for the header row returned fromt the fillTableHeader function is %@", stringTitle);
        
        //Getting the Start and Stop index within the array
        NSMutableString *fileStopIndexNameBody = [self getBusStopIndexFileName:strBusNumber];
        NSLog(@"The file name of the bus stop index is %@", fileStopIndexNameBody);
        //Get the from(aka. start) stop index in the file
        int iBusStart = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:_btnFromField.titleLabel.text];
        //Get the to(aka. destination) stop index in the file
        int iBusStop = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:_btnToField.titleLabel.text];
        
        //define NSMutableString for the title in the output schedule here
        NSMutableString *stringBody = [NSMutableString stringWithCapacity:1];
        //define allocate the output mutable array here string here for the temp var for the fill here
        outputArray = [NSMutableArray arrayWithCapacity:1];
        
         //loop through the new array looking for all line numbers that have _btnFromField.titleLabel.text in it and place those lines into a new array
        [self findStops:busArray iBusStart:iBusStart iBusStop:iBusStop stringBody:&stringBody];
        NSLog(@"Array containing the bus list for the output is %@",outputArray);
        
        //Assign that new array to a table view controller that is the next ending segway
        controllerOut->tblData = outputArray;
        NSLog(@"remote variable for the table data is set to  %@", controllerOut->tblData);
        
        //Assign the header row
        controllerOut->tblSectionName = stringTitle;
        NSLog(@"remote variable for the table title is set to %@", controllerOut->tblSectionName);
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btnFromField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnFromField.layer.borderWidth = .5f;
    _btnFromField.layer.borderColor = [[UIColor blackColor]CGColor];
    _btnFromField.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    _btnToField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnToField.layer.borderWidth = .5f;
    _btnToField.layer.borderColor = [[UIColor blackColor]CGColor];
    _btnToField.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    //[self placeTextBorder:self.FromField];
    //[self placeTextBorder:self.ToField];
    
    //Array of the input for the from seletion
    //tblFromSelection = @[@"W. CALDWELL: Kirkpatrick Lane",@"CALDWELL: Roseland & Bloomfield",@"VERONA: Lakeside Ave",@"W. ORANGE: Pleasantdale Ctr",@"MONTCLAIR: Gates & Bloomfield",@"MONTCLAIR: Grove & Bellvue",@"CLIFTON: Vincent Dr & Groove St",@"BLOOMFIELD: Broad & Liberty",@"BLOOMFIELD: Broad & Watchung",@"NUTLEY: W. Passaic & Darling",@"NYC_P/A Bus Terminal"];
    
    //load the file of stops and take #1 from array and place in array
    tblFromSelection = [self loadStopsFromFile:@"BusListNew"];
    [tblFromSelection addObject:@"NYC_P/A Bus Terminal"];
    //tblFromSelection = busNumArray;
    /*for(int i=0; i<busNumArray.count;i++)
    {
        [tblFromSelection addObject:busNumArray[i][0]];
    }*/
}

- (IBAction)unwindFromStopSelectViewController:(UIStoryboardSegue *)segue
{
    TableViewControllerFromSelect *controller = segue.sourceViewController;
    //Check to see if anything was selected, if nothing then lets just exit
    if(controller->tblFromSectionName)
    {
        if(controller.from == YES)
        {
            [_btnFromField setTitle: controller->tblFromSectionName forState:UIControlStateNormal];

        }
        else
        {
            [_btnToField setTitle: controller->tblFromSectionName forState:UIControlStateNormal];

        }
    }


}
- (IBAction)btnFromPressed:(id)sender {
    //this is thew from button
    [self setFrom:YES];
}

- (IBAction)btnToPressed:(id)sender {
    //this is the to button
    [self setFrom:NO];
    //call out to segway
    [self performSegueWithIdentifier:@"segwayShowFromTable" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
