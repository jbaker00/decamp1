//
//  TextInputViewViewController.m
//  DeCampV3
//
//  Created by Baker, James on 11/29/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "TextInputViewViewController.h"
#import "TableViewControllerFromSelect.h"

@interface TextInputViewViewController ()
@end

@implementation TextInputViewViewController
NSArray *tblFromSelection;


//- (NSMutableArray*)getBusStops:(NSString*)busStop forTime:(NSSTimeInterval*)timeInterval;
//Function to load strings into an array from a file
-(NSMutableArray*)loadStopIndexFromFile:(NSString*)fileName //add a 2nd value of an array name
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
   
    NSMutableArray *stopArray = [[NSMutableArray alloc]initWithCapacity:1];; //string to store the output of the stops
    
    int i = 0; //counter for the string array
    
    for (NSString *row in rows){
        if(![row isEqualToString:@""])
        {

            NSLog(@"adding %@ into the stopArray at location [%i]",row, i);
            [stopArray addObject:row];
        }
        else
        {
            NSLog(@"We found a blank line");
        }
        i++;
    }
    return(stopArray);
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

- (NSString *)loadBusNumber:(NSString *)startStop {
    NSString *strBusNumber = @"33";
    return strBusNumber;
}

- (void)printDebugInfo:(NSString *)strBusNumber {
    NSLog(@"from location is, %@",_btnFromField.titleLabel.text);
    NSLog(@"to location is , %@", _btnToField.titleLabel.text);
    NSLog(@"weekend is set to, , %i", _segWeekend.selected);
    NSLog(@"time of day is set to, %@", _departureTime.date);
    NSLog(@"Bus number is %@", strBusNumber);
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
        TableViewController *controller = [segue destinationViewController];
        
        //Lookup Bus Number
        NSString * strBusNumber = [self loadBusNumber:_btnFromField.titleLabel.text];
        NSLog(@"The Bus number returned fromt eh loadBusNumber lookup was %@", strBusNumber);
        
        //Debug info
        [self printDebugInfo:strBusNumber];
        
        //$$TODO$$ make this a function that will return back the index of the stop name passed in. use the 33 file in this case since we hard code it
        //NSMutableArray* stopIndexes = [self loadStopIndexFromFile:@"33stopsToNYC"];
        int iBusStart = 4;
        int iBusStop = 12;
        
        
        //Load the file of the 33 to NYC info
        NSMutableArray *busArray = [self loadStopsFromFile:@"3"];
        NSLog(@"Debug output of the mutable array bus start time is %@", busArray[7][iBusStart]);
        NSLog(@"Debug output of the mutable array bus stop time is %@", busArray[7][iBusStop]);
        
        //Fill ou the header row
        NSString *stringTitle = [self fillTableHeader:strBusNumber];
        NSLog(@"Title for the header row returned fromt the fillTableHeader function is %@", stringTitle);
        
        //define nsMutableArray for the fill here
        NSMutableString *stringBody = [NSMutableString stringWithCapacity:1];
        
         //define nsmutable string here for the temp var for the fill here
         NSMutableArray *outputArray = [NSMutableArray arrayWithCapacity:1];
         
         //loop through the new array looking for all line numbers that have _btnFromField.titleLabel.text in it and place those lines into a new array
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
                 [stringBody appendString:busArray[i][iBusStart]];
                 [stringBody appendString:@" - "];
                 [stringBody appendString:busArray[i][iBusStop]];
                 NSLog(@"The output for the table will be %@", stringBody);
                 
                 //Add the string to an output array
                 [outputArray addObject:stringBody];
                 
                 //clear out string for next placement in of new string
                 stringBody = [NSMutableString stringWithString:@""];
             }
         
         }
         NSLog(@"%@",outputArray);
        
        //Assign that new array to a table view controller that is the next ending segway
        controller->tblData = outputArray;
        
        //Assign the header row
        controller->tblSectionName = strBusNumber;
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
    tblFromSelection = @[@"W. CALDWELL: Kirkpatrick Lane",@"CALDWELL: Roseland & Bloomfield",@"VERONA: Lakeside Ave",@"W. ORANGE: Pleasantdale Ctr",@"MONTCLAIR: Gates & Bloomfield",@"MONTCLAIR: Grove & Bellvue",@"CLIFTON: Vincent Dr & Groove St",@"BLOOMFIELD: Broad & Liberty",@"BLOOMFIELD: Broad & Watchung",@"NUTLEY: W. Passaic & Darling",@"NYC_P/A Bus Terminal"];
  
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
