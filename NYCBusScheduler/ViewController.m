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
#import "ScheduleViewController.h"
//#import <AmazonAd/AmazonAdView.h>
//#import <AmazonAd/AmazonAdOptions.h>
//#import <AmazonAd/AmazonAdError.h>
@import GoogleMobileAds;
#import <sys/utsname.h>

//Use <AmazonAdViewDelegate> if using Amazon ads
@interface ViewController () <GADBannerViewDelegate>
{
    
}

//@property (nonatomic, retain) AmazonAdView *amazonAdView;
@property(nonatomic, strong) GADBannerView *bannerView;


@end


    NSMutableArray *tblBusSrc;
    NSMutableArray *tblBusDest;
    NSMutableArray *outputArray;
    NSString *stringTitle;
    NSString *busRoutes;


@implementation ViewController

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-7871017136061682~2467792962"];
    return YES;
    
}

/*for amazon Ads
@synthesize amazonAdView;
@synthesize lastOrientation;
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize Data
    NSLog(@"Entering ViewController::viewDidLoad");

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
    NSLog(@"Exiting ViewController::viewDidLoad");

}

- (void)viewDidAppear:(BOOL)animated
{
    //[self loadAmazonAd];
    [self loadGoogleAd];
}

- (BOOL)isLargeDevice
{
    NSLog(@"Entering ViewController::isLargeDevice");
    BOOL bReturn = NO;
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* smallDevices = nil;
    if(!smallDevices) {
        smallDevices = @{ @"i386"      : @"Simulator",
                          @"x86_64"    : @"Simulator",
                          @"iPod1,1"   : @"iPod Touch",        // (Original)
                          @"iPod2,1"   : @"iPod Touch",        // (Second Generation)
                          @"iPod3,1"   : @"iPod Touch",        // (Third Generation)
                          @"iPod4,1"   : @"iPod Touch",        // (Fourth Generation)
                          @"iPod7,1"   : @"iPod Touch",        // (6th Generation)
                          @"iPhone1,1" : @"iPhone",            // (Original)
                          @"iPhone1,2" : @"iPhone",            // (3G)
                          @"iPhone2,1" : @"iPhone",            // (3GS)
                          @"iPad1,1"   : @"iPad",              // (Original)
                          @"iPad2,1"   : @"iPad 2",            //
                          @"iPad3,1"   : @"iPad",              // (3rd Generation)
                          @"iPhone3,1" : @"iPhone 4",          // (GSM)
                          @"iPhone3,3" : @"iPhone 4",          // (CDMA/Verizon/Sprint)
                          @"iPhone4,1" : @"iPhone 4S",         //
                          @"iPhone5,1" : @"iPhone 5",          // (model A1428, AT&T/Canada)
                          @"iPhone5,2" : @"iPhone 5",          // (model A1429, everything else)
                          @"iPhone5,3" : @"iPhone 5c",         // (model A1456, A1532 | GSM)
                          @"iPhone5,4" : @"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                          @"iPhone6,1" : @"iPhone 5s",         // (model A1433, A1533 | GSM)
                          @"iPhone6,2" : @"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                          };
    }
    
    NSString* deviceName = [smallDevices objectForKey:code];
    
    if(!deviceName)
        bReturn = YES; //Device name found therefore its not a large device
    else
        bReturn = NO; //Device name not found there its a large device
    
    
    NSLog(@"Exiting ViewController::isLargeDevice");
    return bReturn;
}

/*- (NSString*)findDeviceName
{
    NSLog(@"Entering ViewController::findDeviceName");

    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
  
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      : @"Simulator",
                              @"x86_64"    : @"Simulator",
                              @"iPod1,1"   : @"iPod Touch",        // (Original)
                              @"iPod2,1"   : @"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   : @"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   : @"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   : @"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" : @"iPhone",            // (Original)
                              @"iPhone1,2" : @"iPhone",            // (3G)
                              @"iPhone2,1" : @"iPhone",            // (3GS)
                              @"iPad1,1"   : @"iPad",              // (Original)
                              @"iPad2,1"   : @"iPad 2",            //
                              @"iPad3,1"   : @"iPad",              // (3rd Generation)
                              @"iPhone3,1" : @"iPhone 4",          // (GSM)
                              @"iPhone3,3" : @"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" : @"iPhone 4S",         //
                              @"iPhone5,1" : @"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" : @"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   : @"iPad",              // (4th Generation)
                              @"iPad2,5"   : @"iPad Mini",         // (Original)
                              @"iPhone5,3" : @"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" : @"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" : @"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" : @"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" : @"iPhone 6 Plus",     //
                              @"iPhone7,2" : @"iPhone 6",          //
                              @"iPhone8,1" : @"iPhone 6S",         //
                              @"iPhone8,2" : @"iPhone 6S Plus",    //
                              @"iPhone8,4" : @"iPhone SE",         //
                              @"iPhone9,1" : @"iPhone 7",          //
                              @"iPhone9,3" : @"iPhone 7",          //
                              @"iPhone9,2" : @"iPhone 7 Plus",     //
                              @"iPhone9,4" : @"iPhone 7 Plus",     //
                              @"iPhone10,1": @"iPhone 8",          // CDMA
                              @"iPhone10,4": @"iPhone 8",          // GSM
                              @"iPhone10,2": @"iPhone 8 Plus",     // CDMA
                              @"iPhone10,5": @"iPhone 8 Plus",     // GSM
                              @"iPhone10,3": @"iPhone X",          // CDMA
                              @"iPhone10,6": @"iPhone X",          // GSM
                              
                              @"iPad4,1"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   : @"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   : @"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   : @"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   : @"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   : @"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    NSLog(@"Exiting ViewController::findDeviceName");

    return deviceName;
}*/


-(void) loadGoogleAd
{
    NSLog(@"Entering ViewController::loadGoogleAd");
    //NSString* deviceType = [self findDeviceName];
    //NSLog(@"Device type is %@", deviceType);
    
    if([self isLargeDevice])
    {
        self.bannerView = [[GADBannerView alloc]
                           initWithAdSize:kGADAdSizeMediumRectangle/*kGADAdSizeLargeBanner kGADAdSizeFluid kGADAdSizeMediumRectangle kGADAdSizeBanner*/];
        NSLog(@"Set the banner add with size kGADAdSizeMediumRectangle");
    }
    else
    {
        self.bannerView = [[GADBannerView alloc]
                           initWithAdSize:kGADAdSizeLargeBanner/* kGADAdSizeMediumRectangle kGADAdSizeLargeBanner kGADAdSizeFluid kGADAdSizeMediumRectangle kGADAdSizeBanner*/];
        NSLog(@"Set the banner add with size kGADAdSizeLargeBanner");
    }
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
  
    NSLog(@"Exiting ViewController::loadGoogleAd");

}

/*- (void )loadAmazonAd
{
    NSLog(@"Entering ViewController::loadAmazonAd");

    //Bannar AD
    if (self.amazonAdView) {
        [self.amazonAdView removeFromSuperview];
        self.amazonAdView = nil;
    }

    NSLog(@"Bottom of screen location is %f",[UIScreen mainScreen].bounds.size.height);
    NSLog(@"Height of the ad is %f",amazonAdView.frame.size.height);

    const CGRect adFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 90, [UIScreen mainScreen].bounds.size.width, 90);
    //const CGRect adFrame = CGRectMake(0.0f, 200.0f, [UIScreen mainScreen].bounds.size.width, 90.0f);

    self.amazonAdView = [[AmazonAdView alloc] initWithFrame:adFrame];
    //self.amazonAdView = [AmazonAdView amazonAdViewWithAdSize:AmazonAdSize_320x50];

    [self.amazonAdView setHorizontalAlignment:AmazonAdHorizontalAlignmentCenter];
    [self.amazonAdView setVerticalAlignment:AmazonAdVerticalAlignmentBottom];
    
    // Register the ViewController with the delegate to receive callbacks.
    self.amazonAdView.delegate = self;
    
    //Set the ad options and load the ad
    AmazonAdOptions *options = [AmazonAdOptions options];
    
    //Turn on if running tests
    options.isTestRequest = NO;

    [self.amazonAdView loadAd:options];
    
 NSLog(@"Exiting ViewController::loadAmazonAd");

}*/

-(void)placeTextBorder:(UIButton*)btnField
{
    NSLog(@"Entering ViewController::placeTextBorder");

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
    
    NSLog(@"Exiting ViewController::placeTextBorder");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFromPressed:(id)sender {
    NSLog(@"Entering ViewController::btnFromPressed");

    //this is thew from button
    [self setFrom:YES];
    //We are not using current location here so set it to no
    [self setCurLocUsed:NO];
    //call out to segway
    [self performSegueWithIdentifier:@"segwayShowFromTable" sender:self];
   
    NSLog(@"Exiting ViewController::btnFromPressed");

}


- (IBAction)btnToPressed:(id)sender {
    NSLog(@"Entering ViewController::btnToPressed");

    //this is the to button
    [self setFrom:NO];
    //We are not using current location so set it to no
    [self setCurLocUsed:NO];
    //call out to segway
    [self performSegueWithIdentifier:@"segwayShowFromTable" sender:self];

    NSLog(@"Exiting ViewController::btnToPressed");
}



- (IBAction)unwindFromStopSelectViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"Entering ViewController::unwindFromStopSelectViewController");
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
    NSLog(@"Exiting ViewController::unwindFromStopSelectViewController");

}
    
-(NSMutableArray*)loadStopsFromFile:(NSString*)fileName
{
    NSLog(@"Entering ViewController::loadStopsFromFile");

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
    
    NSLog(@"Exiting ViewController::loadStopsFromFile");

    return rowArray;
}

- (NSString *)loadBusNumber:(NSString *)startStop destStop:(NSString *)destStop{
    NSString *strBusNumber;
    
    //Load the bus array of busses and stops
    NSLog(@"Entering ViewController::loadBusNumber");
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

    NSLog(@"Exiting ViewController::loadBusNumber");
    return strBusNumber;
}

- (void)printDebugInfo:(NSString *)strBusNumber {
    NSLog(@"Entering ViewController::printDebugInfo");

    NSLog(@"from location is, %@",_btnFrom.titleLabel.text);
    NSLog(@"to location is , %@", _btnTo.titleLabel.text);
    NSLog(@"weekend is set to, , %i", _segWeekday.selected);
    NSLog(@"time of day is set to, %@", _departureTime.date);
    NSLog(@"Bus number is %@", strBusNumber);
    
    NSLog(@"Exiting ViewController::printDebugInfo");

}

- (NSString *)getBusScheduleFileName:(NSString *)strBusNumber {
    NSLog(@"Entering ViewController::getBusScheduleFileName");

    
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
    
    NSLog(@"Exiting ViewController::getBusScheduleFileName");
    return returnString;
}


//Is this function even needed $$TODO$$  we return the btn text string we used to have to create the string from the number and the text but they are together now
- (NSString*)fillTableHeader:(NSString *)strBusNumber
{
    NSLog(@"Entering ViewController::fillTableHeader");

    NSMutableString *stringTitle = [NSMutableString stringWithString:_btnFrom.titleLabel.text];
    NSLog(@"The string of the title is %@", stringTitle);
    NSLog(@"Exiting ViewController::fillTableHeader");
    return stringTitle;
}

- (NSString *)getBusStopIndexFileName:(NSString *)strBusNumber
{
    NSLog(@"Entering ViewController::getBusStopIndexFileName");
    
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
    
    NSLog(@"Exiting ViewController::getBusStopIndexFileName");
    return returnString;
}

//Function to load strings into an array from a file
-(int)loadStopIndexFromFile:(NSString*)fileName busStopName:(NSString*)stopName//add a 2nd value of an array name
{
    NSLog(@"Entering ViewController::loadStopIndexFromFile");

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
    NSLog(@"Exiting ViewController::loadStopIndexFromFile");
    return(0);
}

- (void)findStops:(NSMutableArray *)busArray iBusStart:(int)iBusStart iBusStop:(int)iBusStop
{
    NSLog(@"Entering ViewController::findStops");
 
    NSMutableString *stringBody = [NSMutableString stringWithCapacity:1];
    
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
        
    }
    if(outputArray.count == 0)
    {
        //Add the string to an output array
        [outputArray addObject:@"No Bus Schedule Available for Route"];
    }
    NSLog(@"Entering ViewController::findStops");
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Entering ViewController::prepareForSegue");

    if ([[segue identifier] isEqualToString:@"segwayShowFromTable"])
    {
        NSLog(@"Calling Segway for segwayShowFromTable");
        //Grab the view controller
        StopsTableVC *controller = [segue destinationViewController];
        
        //I do not think this part of the code could ever be hit if self.from == YES
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
        ScheduleViewController *controllerOut = [segue destinationViewController];
        
        if(!self.curLocUsed)
        {
            //Lookup Bus Number
            NSString *strBusNumber = [self loadBusNumber:_btnFrom.titleLabel.text destStop:_btnTo.titleLabel.text];
            NSLog(@"The Bus number returned fromt the loadBusNumber lookup was %@", strBusNumber);
            
            //Debug info
            //[self printDebugInfo:strBusNumber];
            
            //Get the file name of the bus schedule
            NSString *fileNameBody = [self getBusScheduleFileName:strBusNumber];
            NSLog(@"The file name of the bus schedule is %@", fileNameBody);
            
            //Load the file of the bus schedule
            NSMutableArray *busArray = [self loadStopsFromFile:fileNameBody];
            NSLog(@"Array containg the bus schedule for the route %@ bus is %@", strBusNumber, busArray);
            
            //Fill ou the header row
            //stringTitle = [self fillTableHeader:strBusNumber];
            stringTitle = _btnFrom.titleLabel.text;
            NSLog(@"Title for the header row returned fromt the fillTableHeader function is %@", stringTitle);
            
            //Get the file name of the bus stop index file
            NSString *fileStopIndexNameBody = [self getBusStopIndexFileName:strBusNumber];
            NSLog(@"The file name of the bus stop index is %@", fileStopIndexNameBody);
            
            //Get the from(aka. start) stop index in the file
            int iBusStart = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:_btnFrom.titleLabel.text];
            NSLog(@"Starting bus stop index is %i", iBusStart);
            //Get the to(aka. destination) stop index in the file
            int iBusStop = [self loadStopIndexFromFile:fileStopIndexNameBody busStopName:_btnTo.titleLabel.text];
            NSLog(@"Stopping bus stop index is %i", iBusStop);
            
            //define allocate the output mutable array here string here for the temp var for the fill here
            outputArray = [NSMutableArray arrayWithCapacity:1];
            
            //loop through the new array looking for all line numbers that have _btnFromField.titleLabel.text in it and place those lines into a new array
            [self findStops:busArray iBusStart:iBusStart iBusStop:iBusStop];
            NSLog(@"Array containing the bus list for the output is %@",outputArray);
            
            //Assign that new array to a table view controller that is the next ending segway
            controllerOut->tblFromData = outputArray;
            NSLog(@"remote variable for the table data is set to  %@", controllerOut->tblFromData);
            
            //Assign the header row
            controllerOut->tblFromSectionName = stringTitle;
            NSLog(@"remote variable for the table title is set to %@", controllerOut->tblFromSectionName);
             
            //set the NSArrary for the table to be filled
            controllerOut->tblStopData = tblBusSrc;
            
            //set the destination for the bus to be used in looking up ETA of transit
            controllerOut->strDestination = _btnTo.titleLabel.text;

        }
        else
        {
            //set the NSArrary for the table to be filled
            controllerOut->tblStopData = tblBusSrc;
            
            //Pass over my locaiton
            controllerOut->locationMe = locationMe;
            
            //Using the current locaiton so pass it over
            [controllerOut setCurLocUsed:YES];
            
            //pass in our destination
            controllerOut->strDestination = _btnTo.titleLabel.text;
            
            controllerOut->nsiWeekend = _segWeekday.selectedSegmentIndex;
        }
        
    }
    NSLog(@"Exiting ViewController::prepareForSegue");

}
- (IBAction)getCurLocation:(id)sender
{
    NSLog(@"Entering ViewController::getCurLocation");

    //Check to see if the location manager is already allocated since its a global.  if it isnt then do the block below
    NSLog(@"Checking the location manager to see if it is allready allocated");
    if (locationManager == nil)
    {
        NSLog(@"locationManager is not allocated so we will allocate it");
        locationManager = [[CLLocationManager alloc] init];
        NSLog(@"allocation of locationManager done");
        
        [locationManager setDelegate:self];
        NSLog(@"locaitonManager delegate set to self so we can get the callbacks like location change");
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        NSLog(@"locationManager desired acuracy set to best accuracy");
        
        [locationManager startUpdatingLocation];
        NSLog(@"locationManager call to start updating locations so we can get our callbacks done");
    }
    
    NSLog(@"Check to see if location services are enabled");
    if(CLLocationManager.locationServicesEnabled == true)
    {
        NSLog(@"location services are enabled, now check to see if we are authorized to use the location services or if we need to request authorization");
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
           [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
           [CLLocationManager authorizationStatus ] == kCLAuthorizationStatusNotDetermined)
        {
            NSLog(@"either kCLAuthorizationStatusRestricted or kCLAuthorizationStatusDenied or kCLAuthorizationStatusNotDetermined is set and therefore we need to prompt for user authorization ");
            [locationManager requestWhenInUseAuthorization];
        }
        NSLog(@"We are  authorized for using location services so lets start using them");
        
        //Change the text for the button to say loading
        [_btnFrom setTitle:@"Loading..." forState:UIControlStateNormal];
        
        //refresh the UI to show the button text saying the reverse geo locaiton
        [_btnFrom setNeedsLayout];
        [_btnFrom layoutIfNeeded];
        [self setCurLocUsed:YES];
    }
    else
    {
        NSString *strError = @"pleaase turn on location services";
        NSLog(@"%@", strError);
        [self setCurLocUsed:NO];

    }
    NSLog(@"Entering ViewController::getCurLocation");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Entering locationManager::didUpdateLocations sub class ViewController");

    //store current location into a class variable
    locationMe = [locations lastObject];
    //Put location into a 2d cordinate
    //CLLocationCoordinate2D coord = {locationMe.coordinate.latitude, locationMe.coordinate.longitude};
    NSLog(@"the latitude is %f", locationMe.coordinate.latitude);
    NSLog(@"the longitude is %f", locationMe.coordinate.longitude);
    
    //get the street addrss and place it into the outbound text box
    [self reverseGeocode:locationMe];
    //_btnFrom.titleLabel.text = strMyLoc;
    NSLog(@"Exiting locationManager::didUpdateLocations sub class ViewController");

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Entering locationManager::didFailWithError sub class ViewController");
    NSLog(@"We hit an error as we are entering ::didFailWithError method");
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:
                NSLog(@"didFailWithError:Error Denied");
            case kCLErrorLocationUnknown:
                NSLog(@"didFailWithError:Error Location Unknown");
            default:
                NSLog(@"didFailWithError:Error other");
                break;
        }
        
    } else {
        NSLog(@"didFailWithError:Error not in the KCLErrorDomain but still received an error");
    }
    NSLog(@"Exiting locationManager::didFailWithError sub class ViewController");

}

//Get the location name from lat and long
- (void)reverseGeocode:(CLLocation *)location
{
    NSLog(@"Entering ViewController::reverseGeocode");

    //*strReturn;

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
            NSLog(@"Entering ViewController::reverseGeocodeLocation");
            if(self.curLocUsed)
            {
                 
                 NSLog(@"Finding address");
                 if (error)
                 {
                     NSLog(@"Error %@", error.description);
                 }
                 else
                 {
                     NSLog(@"there are %lu placemarks in the array of placemarks", (unsigned long)placemarks.count);
                     CLPlacemark *placemark = placemarks[0];// [placemarks lastObject];
                     NSLog(@"name = %@", placemark.name);
                     NSLog(@"ISOcountryCode = %@", placemark.ISOcountryCode);
                     NSLog(@"country = %@", placemark.country);
                     NSLog(@"postalCode = %@", placemark.postalCode);
                     NSLog(@"administrativeArea = %@", placemark.administrativeArea);
                     NSLog(@"subAdministrativeArea = %@", placemark.subAdministrativeArea);
                     NSLog(@"locality = %@", placemark.locality);
                     NSLog(@"subLocality = %@", placemark.subLocality);
                     NSLog(@"thoroughfare = %@", placemark.thoroughfare);
                     NSLog(@"subThoroughfare = %@", placemark.subThoroughfare);
                     NSLog(@"timeZone = %@", placemark.timeZone);
                     
                     self->strMyLoc = [NSString stringWithFormat:@"%@ %@ %@ %@ ", placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea];
                     
                     //Check to see if this is NYC for state and city and if so switch the start location back to Port Authority and do a popup saying you are in nyc
                     if([placemark.administrativeArea isEqualToString:@"NY"] && [placemark.subLocality isEqualToString:@"Manhattan"])
                     {
                         //Change the text for the button to say current location
                         [self->_btnFrom setTitle:@"NYC_P/A Bus Terminal" forState:UIControlStateNormal];
                         
                         //set the instance variable to say the current location is being used
                         [self setCurLocUsed:NO];
                     }
                     else
                     {
                         //Change the text for the button to say current location
                         [self->_btnFrom setTitle:self->strMyLoc forState:UIControlStateNormal];

                         //set the instance variable to say the current location is being used
                         [self setCurLocUsed:YES];
                     }
                     //refresh the UI to show the button text saying the reverse geo locaiton
                     [self->_btnFrom setNeedsLayout];
                     [self->_btnFrom layoutIfNeeded];
                 }
            NSLog(@"Exiting ViewController::reverseGeocodeLocation");
            }
     }];
    NSLog(@"Exiting ViewController::reverseGeocode");

}

#pragma GoogleAdsCode
- (void)addBannerViewToView:(UIView *)bannerView {
    NSLog(@"Entering ViewController::addBannerViewToView");
    
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
    NSLog(@"Exiting ViewController::addBannerViewToView");
}
/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"ScheduleViewController::adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"ScheduleViewController::adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"ScheduleViewController::adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"ScheduleViewController::adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"ScheduleViewController::adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"ScheduleViewController::adViewWillLeaveApplication");
}


/*#pragma mark UIContentContainer protocol For Amazon Ads
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        // Reload Amazon Ad upon rotation.
        // Important: Amazon expandable rich media ads target landscape and portrait mode separately.
        // If your app supports device rotation events, your app must reload the ad when rotating between portrait and landscape mode.
        [self loadAmazonAd];
    }];
}

#pragma mark AmazonAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidLoad:(AmazonAdView *)view
{
    // Add the newly created Amazon Ad view to our view.
    [self.view addSubview:view];
    NSLog(@"Ad loaded");
}

- (void)adViewDidFailToLoad:(AmazonAdView *)view withError:(AmazonAdError *)error
{
    NSLog(@"Ad Failed to load. Error code %d: %@", error.errorCode, error.errorDescription);
}

- (void)adViewWillExpand:(AmazonAdView *)view
{
    NSLog(@"Ad will expand");
    // Save orientation so when our ad collapses we can reload an ad
    // Also useful if you need to programmatically rearrange view on orientation change
    lastOrientation = [[UIApplication sharedApplication] statusBarOrientation];
}

- (void)adViewDidCollapse:(AmazonAdView *)view
{
    NSLog(@"Ad has collapsed");
    // Check for if the orientation has changed while the view disappeared.
    if (lastOrientation != [[UIApplication sharedApplication] statusBarOrientation]) {
        [self loadAmazonAd];
    }
}
*/



@end
