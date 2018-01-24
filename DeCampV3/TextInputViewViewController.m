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

- (IBAction)FindBus:(id)sender
 {
     int i,j; //ints for the loops
     NSString *busArray[50][12];
     
     NSLog(@"from location is, %@",_btnFromField.titleLabel.text);
     NSLog(@"to location is , %@", _btnToField.titleLabel.text);
     NSLog(@"weekend is set to, , %i", _segWeekend.selected);
     NSLog(@"time of day is set to, %@", _departureTime.date);
     
     //Set the error Variable to NIL that we will check later
     NSError *error = nil;
     //Setup the bundle so we can read the file
     NSBundle *main =[NSBundle mainBundle];
     //Setup the file name in the bundlle
     NSString *path = [main pathForResource:@"3" ofType:@"txt"];
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
     
     //set the row counter at the beginning
     i=0;
     
     //Loop through each row and take each delimiter of the comma and place each item in a column that is delimited
     for (NSString *row in rows){
         if(![rows[i] isEqualToString:@""])
         {
             NSArray* columns = [row componentsSeparatedByString:@","];
             for(j=0; j< 13; j++)
             {
                 NSLog(@"adding %@ into the stringArray at location [%i], [%i]",columns[j], i,j);
                 busArray[i][j] = columns[j];
             }
         }
         else
         {
             NSLog(@"We found a blank line");
         }
         
         //increment the counter for the rows
         i++;
     }
     NSLog(@"exiting the fill in loop");
     //Assume there was a lookup of the from field and the bus number  and we got back 33 :) 
     
     
     //look up the specific index in the table (now array busArray) that matches the _btnFromField.titleLAbel.txt
     
     
     //loop through the new array looking for all line numbers that have _btnFromField.titleLabel.text in it and place those lines into a new array
     int l;
     for(l=0; l<rows.count; l++)
     {
         //check the index that fits for the specific stop
     }
 }

/*- (IBAction)FindBus:(id)sender
{
    //Check From Field input for the from location and the To location and return back the array for the table from the dictionary that has all the bus routes for that time period
    
    NSLog(@"from location is, %@",_btnFromField.titleLabel.text);
    NSLog(@"to location is , %@", _btnToField.titleLabel.text);
    NSLog(@"weekend is set to, , %i", _segWeekend.selected);
    NSLog(@"time of day is set to, %@", _departureTime.date);
    
    //Time to build out an arraywhich will be our schedule and push it to a table  (this shold be done i a seperate funcion or with a class and the init mthod taking in the file name based on the bus number needed post a lookup of the stop existing on a bus number
    //We also need error logic here to say if a stop combo doesnt exit within any route
    
    //really we will chise which resource file to load here, but for testing we will oly load 33 weekday bus
    //Array of all the values in columnA which is the trip number
    NSMutableArray *colATripNum = [NSMutableArray array];
    //Array of all the values in columnB which is the Bus number
    NSMutableArray *colBBusNum = [NSMutableArray array];
    //Array of all the values in columnC which is the Stop name
    NSMutableArray *colCStopName = [NSMutableArray array];
    //Array of all the values in columnD Which is the time which the bus reaches the stop
    NSMutableArray *colDStopTime = [NSMutableArray array];
    
    //Set the error Variable to NIL that we will check later
    NSError *error = nil;
    //Setup the bundle so we can read the file
    NSBundle *main =[NSBundle mainBundle];
    //Setup the file name in the bundlle
    NSString *path = [main pathForResource:@"3" ofType:@"txt"];
    //Load the file contents into a string
    NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    //Check for the error code to see if the file read worked
    if(nil != error)
    {
        NSLog(@"Error Resding URL with error %@", error.localizedDescription);
    }
    //Look at the contents of the file loaded into the string and parse it for the columns per row
    //Set the row seperator
    NSArray* rows = [fileContents componentsSeparatedByString:@"\r"];
    //Loop through each row and take each delimiter of the comma and place each item in a column that is delimited
    for (NSString *row in rows){
        NSArray* columns = [row componentsSeparatedByString:@","];
        [colATripNum addObject:columns[0]];
        [colBBusNum addObject:columns[1]];
        [colCStopName addObject:columns[2]];
        [colDStopTime addObject:columns[3]];
    }
    
    //Time to do the searching
    NSLog(@"ready to do searches");

    //Get the row numbers that corespond with the pickup location specified
    //loop the (colCStopName) and get all the row numbers and put them in an array (arrayOfOrigStopRows)of trip numbers that match the stop

    //Get the stop times for all the rorws found above where there is a pickup location requested on that row, identifying the stop times by their row numbers
    //loop the (colDStopTime) looking for stop times that match the row numbers from (arrayOfOrigStopRows) give and place the row numbers that are greater than the time requested in a new array (arrayOfOrigStopTimeRows)
    
    //Get the trip numbers for all the row numbers from the last lookup that gave us the pickup location with the stop time equal to that requested
    //loop the (colATripNum) array and look for trip numbers that match the entries in (arrayOfStopTimeRows) and store them in a new array (arrayTripNums)
    
    //Use the trip numbers row numbers to find the rows that have our destination requested
    //Loop the (colCStopName) looking at rows that have the destination name and place it in an array (arrayOfDestStopTimeROws)
    
    //Loop the (colStopTime) looking at the rows specified by (arrayOfDestStopTimeROws) and get the stop times listed for these rows and this is our destination times (arrayofDestStopTimes)
    
    //Make a table with
    //btnFromField.titleLabel.text
    //arrayOfOrigStopTimeRows[]
    //_btnToField.titleLabel.text
    //arrayofDestStopTimes[]
    
}*/
/*- (IBAction)btnFromField:(id)sender {
    NSLog(@"touch up inside From Field Button");
}
- (IBAction)btnToField:(id)sender {
    NSLog(@"touch up inside To Field Button");
}*/

/*-(void)placeTextBorder:(UITextField*)textField
{
    //Bottom border textField
    CALayer *bottomBorderFrom = [CALayer layer];
    bottomBorderFrom.frame = CGRectMake(0.0f, textField.frame.size.height -1, textField.frame.size.width, 1.0f);
    bottomBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [textField.layer addSublayer:bottomBorderFrom];
    
    // Left border FromField
    CALayer *leftBorderFrom = [CALayer layer];
    leftBorderFrom.frame = CGRectMake(0.0f, 20.0f, 1.0f, textField.frame.size.height-20);
    leftBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [textField.layer addSublayer:leftBorderFrom];
    
    // Right border FromField
    CALayer *rightBorderFrom = [CALayer layer];
    rightBorderFrom.frame = CGRectMake(textField.frame.size.width-1, 20.0f, 1.0f, textField.frame.size.height-20);
    rightBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [textField.layer addSublayer:rightBorderFrom];
}*/

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
