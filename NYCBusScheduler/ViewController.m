//
//  ViewController.m
//  DeCampV3
//
//  Created by Baker, James on 10/23/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "StopsTableVC.h"
#import "scheduleTableVC.h"
@import GoogleMobileAds;


@interface ViewController () <GADBannerViewDelegate>
{
}

@property(nonatomic, strong) GADBannerView *bannerView;


@end

@implementation ViewController
NSMutableArray *tblBusSrc;
NSMutableArray *tblBusDest;
NSMutableArray *outputArray;
NSString *stringTitle;
NSString *busRoutes;



-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-7871017136061682~2467792962"];
    return YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize Data

    
    //Add loading
    // In this case, we instantiate the banner with desired ad size.
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeLargeBanner /*kGADAdSizeMediumRectangle kGADAdSizeBanner*/];
    NSLog(@"Set the banner add with size kGADAdSizeLargeBanner");

    //set the googleAds delegate
    self.bannerView.delegate = self;
    
    [self addBannerViewToView:_bannerView];
    NSLog(@"add the banner add to the view with addBannerViewToView:_bannerView]");
    
    //self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    //NSLog(@"set the ad Unit to the test unit of ca-app-pub-3940256099942544/2934735716");
    self.bannerView.adUnitID = @"ca-app-pub-7871017136061682/5356722325";
    NSLog(@"set the ad Unit to the prod unit of ca-app-pub-7871017136061682/5356722325");
    self.bannerView.rootViewController = self;
    NSLog(@"Calling to load the banner ad into the view");
    [self.bannerView loadRequest:[GADRequest request]];
    NSLog(@"Called to load the banner ad into the view");

    [self placeTextBorder:self.btnTo];
    [self placeTextBorder:self.btnFrom];
    
    
    //allocate space in the array
    tblBusDest = [NSMutableArray arrayWithCapacity:1];
    //allocate space in the array
    tblBusSrc = [NSMutableArray arrayWithCapacity:1];
    
    //Load the list of Source Bus Stops (From Stops)
    tblBusSrc = [self loadStopsFromFile:@"BusListSrc"];
    // Put the port authorty at top of list
    //[tblBusSrc addObject:@"NYC_P/A Bus Terminal"];


    //Load the list of Deestination Bus Stops (To Stops)
    tblBusDest = [self loadStopsFromFile:@"BusListDest"];
    // Put the port authorty at top of list
    //[tblBusDest addObject:@"NYC_P/A Bus Terminal"];

}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}

-(void)placeTextBorder:(UIButton*)btnField
{
    //Bottom border textField
    
    btnField.layer.borderColor = [[UIColor grayColor] CGColor];
    btnField.layer.borderWidth = 1.0;
    btnField.layer.cornerRadius = 8;
    
    CALayer *bottomBorderFrom = [CALayer layer];
    bottomBorderFrom.frame = CGRectMake(0.0f, btnField.frame.size.height -1, btnField.frame.size.width, 1.0f);
    bottomBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [btnField.layer addSublayer:bottomBorderFrom];
    
    // Left border FromField
    CALayer *leftBorderFrom = [CALayer layer];
    leftBorderFrom.frame = CGRectMake(0.0f, 20.0f, 1.0f, btnField.frame.size.height-20);
    leftBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [btnField.layer addSublayer:leftBorderFrom];
    
    // Right border FromField
    CALayer *rightBorderFrom = [CALayer layer];
    rightBorderFrom.frame = CGRectMake(btnField.frame.size.width-1, 20.0f, 1.0f, btnField.frame.size.height-20);
    rightBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [btnField.layer addSublayer:rightBorderFrom];
    
    btnField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnField.layer.borderWidth = .5f;
    btnField.layer.borderColor = [[UIColor blackColor]CGColor];
    btnField.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFromPressed:(id)sender {
    //this is thew from button
    [self setFrom:YES];
    //call out to segway
    [self performSegueWithIdentifier:@"segwayShowFromTable" sender:self];

}


- (IBAction)btnToPressed:(id)sender {
    //this is the to button
    [self setFrom:NO];
    //call out to segway
    [self performSegueWithIdentifier:@"segwayShowFromTable" sender:self];
}



- (IBAction)unwindFromStopSelectViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"Entering unwinded segway unwindFromStopSelectViewController");
    StopsTableVC *controller = segue.sourceViewController;
    //Check to see if anything was selected, if nothing then lets just exit
    if(controller->tblFromSectionName)
    {
        if(controller.from == YES)
        {
            //Set the From Title of the From button
            [_btnFrom setTitle: controller->tblFromSectionName forState:UIControlStateNormal];
            if(![controller->tblFromSectionName  isEqualToString:@"NYC_P/A Bus Terminal"])
            {
                [_btnTo setTitle: @"NYC_P/A Bus Terminal" forState:UIControlStateNormal];
            }
        }
        else
        {
            //Set the To Title of the To button
            [_btnTo setTitle: controller->tblFromSectionName forState:UIControlStateNormal];
            if(![controller->tblFromSectionName  isEqualToString:@"NYC_P/A Bus Terminal"])
            {
                [_btnFrom setTitle: @"NYC_P/A Bus Terminal" forState:UIControlStateNormal];
            }
            
        }
    }
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

- (NSString *)loadBusNumber:(NSString *)startStop destStop:(NSString *)destStop{
    NSString *strBusNumber;
    
    //Load the bus array of busses and stops
    NSLog(@"loading the bus stop list and bus numbers into an array");

    
    
    //check the start Stop to see if it's NYP if so then use the destination to look up the bus based on that stop
    if(![startStop isEqualToString:@"NYC_P/A Bus Terminal"])
    {
        //Load the Stop file with the src since the src is not NYPA
        NSMutableArray *busNumArray = [self loadStopsFromFile:@"BusListSrc"];
        
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
        //Load the Stop file with the src since the src is NYPA
        NSMutableArray *busNumArray = [self loadStopsFromFile:@"BusListDest"];
       
        //Look up the bus number based off the destStop
        for(int i=0; i<busNumArray.count;i++)
        {
            if([busNumArray[i][0] isEqualToString:destStop])
            {
                strBusNumber = busNumArray[i][1];
            }
        }
    }
    return strBusNumber;
}

- (void)printDebugInfo:(NSString *)strBusNumber {
    NSLog(@"from location is, %@",_btnFrom.titleLabel.text);
    NSLog(@"to location is , %@", _btnTo.titleLabel.text);
    NSLog(@"weekend is set to, , %i", _segWeekday.selected);
    NSLog(@"time of day is set to, %@", _departureTime.date);
    NSLog(@"Bus number is %@", strBusNumber);
}

- (NSString *)getBusScheduleFileName:(NSString *)strBusNumber {
    NSMutableString *fileNameBody; //string to store the file name
    
    fileNameBody = [NSMutableString stringWithCapacity:1];
    
    [fileNameBody appendString:strBusNumber];//append the bus number
    
    //append to or from NYC
    if([_btnFrom.titleLabel.text isEqualToString:@"NYC_P/A Bus Terminal"])
    {
        [fileNameBody appendString:@"fromNYC"]; //append the to for from NYC
    }
    else
    {
        [fileNameBody appendString:@"toNYC"]; //append the to for from NYC
    }
    
    //append the weekday or weekend to the string
    if(_segWeekday.selectedSegmentIndex == 0)
    {
        [fileNameBody appendString:@"Weekdays"];
    }
    else
    {
        [fileNameBody appendString:@"Weekend"];
    }
    NSString *returnString = [fileNameBody stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    return returnString;
}

- (NSString*)fillTableHeader:(NSString *)strBusNumber {
    NSMutableString *stringTitle = [NSMutableString stringWithString:_btnFrom.titleLabel.text];
    NSLog(@"The string of the title is %@", stringTitle);
    return stringTitle;
}

- (NSString *)getBusStopIndexFileName:(NSString *)strBusNumber {
    NSMutableString *fileNameBody; //string to store the file name
    
    fileNameBody = [NSMutableString stringWithCapacity:1];
    
    [fileNameBody appendString:strBusNumber];//append the bus number
    
    //append to or from NYC
    if([_btnFrom.titleLabel.text isEqualToString:@"NYC_P/A Bus Terminal"])
    {
        [fileNameBody appendString:@"fromNYC"]; //append the to for from NYC
    }
    else
    {
        [fileNameBody appendString:@"toNYC"]; //append the to for from NYC
    }
    NSString *returnString = [fileNameBody stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
    return returnString;
}

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

- (void)findStops:(NSMutableArray *)busArray iBusStart:(int)iBusStart iBusStop:(int)iBusStop stringBody:(NSMutableString **)stringBody {
    for(int i=0; i<busArray.count; i++)
    {
        //check the index that fits for the specific stop
        if(![busArray[i][iBusStart] isEqualToString:@""])
        {
            if(![busArray[i][iBusStop] isEqualToString:@""])
            {
                NSLog(@"Starting stop name is %@", _btnFrom.titleLabel.text);
                NSLog(@"Index of the starting stop name in the array is %i", iBusStart);
                NSLog(@"Starting stop time is %@", busArray[i][iBusStart]);
                NSLog(@"Stopping stop name is %@", _btnTo.titleLabel.text);
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
    if(outputArray.count == 0)
    {
        //Add the string to an output array
        [outputArray addObject:@"No Bus Schedule Available for Route"];
    }
}

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"*******adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segwayShowFromTable"])
    {
        NSLog(@"Calling Segway for segwayShowFromTable");
        //Grab the view controller
        StopsTableVC *controller = [segue destinationViewController];
        
        if(self.from == YES)
        {
            //set the NSArrary for the table to be filled
            controller->tblStopData = tblBusSrc;
            //set the section name
            controller->tblFromSectionName = @"Orignation";
            //tell the table view controller on other side of segway this is the origination/src/from bus stop
            [controller setFrom:YES];
        }
        else
        {
            //set the NSArrary for the table to be filled
            controller->tblStopData = tblBusDest;
            //set the section name
            controller->tblFromSectionName = @"Destination";
            //tell the table view controller on other side of segway this is the destination/dest/to bus stop
            [controller setFrom:NO];
        }
    }
    else if ([[segue identifier] isEqualToString:@"showSchedule"])
    {
        NSLog(@"Calling Segway for showSchedule");
        //Get the destination view controller
        scheduleTableVC *controllerOut = [segue destinationViewController];
        
        //Lookup Bus Number
        NSString *strBusNumber = [self loadBusNumber:_btnFrom.titleLabel.text destStop:_btnTo.titleLabel.text];
        NSLog(@"The Bus number returned fromt the loadBusNumber lookup was %@", strBusNumber);
        
        //Debug info
        [self printDebugInfo:strBusNumber];
        
        //Get the file name of the bus schedule
        NSString *fileNameBody = [self getBusScheduleFileName:strBusNumber];
        NSLog(@"The file name of the bus schedule is %@", fileNameBody);
        
        //Load the file of the bus schedule
        NSMutableArray *busArray = [self loadStopsFromFile:fileNameBody];
        NSLog(@"Array containg the bus schedule for the route %@ bus is %@", strBusNumber, busArray);
        
        //Fill ou the header row
        stringTitle = [self fillTableHeader:strBusNumber];
        NSLog(@"Title for the header row returned fromt the fillTableHeader function is %@", stringTitle);
        
        //Getting the Start and Stop index within the array
        NSString *fileStopIndexNameBody = [self getBusStopIndexFileName:strBusNumber];
        NSLog(@"The file name of the bus stop index is %@", fileStopIndexNameBody);
        //Get the from(aka. start) stop index in the file
        int iBusStart = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:_btnFrom.titleLabel.text];
        NSLog(@"Starting bus stop index is %i", iBusStart);
        //Get the to(aka. destination) stop index in the file
        int iBusStop = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:_btnTo.titleLabel.text];
        NSLog(@"Stopping bus stop index is %i", iBusStop);
        
        //define NSMutableString for the title in the output schedule here
        NSMutableString *stringBody = [NSMutableString stringWithCapacity:1];
        //define allocate the output mutable array here string here for the temp var for the fill here
        outputArray = [NSMutableArray arrayWithCapacity:1];
        
        //loop through the new array looking for all line numbers that have _btnFromField.titleLabel.text in it and place those lines into a new array
        [self findStops:busArray iBusStart:iBusStart iBusStop:iBusStop stringBody:&stringBody];
        NSLog(@"Array containing the bus list for the output is %@",outputArray);
        
        //Assign that new array to a table view controller that is the next ending segway
        controllerOut->tblFromData = outputArray;
        NSLog(@"remote variable for the table data is set to  %@", controllerOut->tblFromData);
        
        //Assign the header row
        controllerOut->tblFromSectionName = stringTitle;
        NSLog(@"remote variable for the table title is set to %@", controllerOut->tblFromSectionName);
        
    }
}



@end
