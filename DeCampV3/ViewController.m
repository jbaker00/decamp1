//
//  ViewController.m
//  DeCampV3
//
//  Created by Baker, James on 10/23/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()
{
    //Variables for whats selected
    //int for the chosen bus 33 or 66
    int iBus;
    //int for the chosen route 0 = toNyc 1 = to MTC
    int iRoute;
    //int for the chosen time 0 = AM 1 = PM
    int iTime;
    //int for weekday or weekend 0=Weekdays 1=Weekends
    int iWeek;
    
    //Arrays with the Bus schedules
    //66 Weekdays
    NSArray *tblData66NYCAM;
    NSArray *tblData66NYCPM;
    NSArray *tblData66MTCAM;
    NSArray *tblData66MTCPM;
    
    //33 Weekdays
    NSArray *tblData33NYCAM;
    NSArray *tblData33NYCPM;
    NSArray *tblData33MTCAM;
    NSArray *tblData33MTCPM;
    
    //66 Weekends
    NSArray *tblData66NYCAMWknd;
    NSArray *tblData66NYCPMWknd;
    NSArray *tblData66MTCAMWknd;
    NSArray *tblData66MTCPMWknd;
    
    //33 Weekends
    NSArray *tblData33NYCAMWknd;
    NSArray *tblData33NYCPMWknd;
    NSArray *tblData33MTCAMWknd;
    NSArray *tblData33MTCPMWknd;
    
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize Data

   
    //Initialize the choice selections
    iRoute = 0; //0 = NYC; 1= MTC
    iBus = 33;  //33 bus or 66 bus initialize it to 33 since that is the first selected
    iTime = 0; //0 = AM 1 = PM
    iWeek = 0; //0 = Weekdays 1= Weekends initialize to weekdays since that is first default selected
    
    //66 Weekddays
    tblData66NYCAM = @[@"5:55AM - 6:43AM", @"6:15AM - 7:03AM",@"6:35AM - 7:23AM",@"6:55AM - 7:43AM",@"7:15AM - 8:03AM",@"7:35AM - 8:23AM",@"7:55AM - 8:43AM",@"8:20AM - 9:02AM",@"8:40AM - 9:28AM",@"9:00AM - 9:48AM",@"10:10AM - 10:55AM",@"10:30AM - 11:15AM", @"11:30AM - 12:15AM",@"12:30AM - 1:15AM"];
    tblData66NYCPM = @[@"12:30PM - 1:15PM", @"1:00PM - 1:45PM",@"1:30PM - 2:15PM",@"2:00PM - 2:45PM",@"2:30PM - 3:15PM",@"3:00PM - 3:45PM",@"4:00PM - 4:45PM",@"5:00PM - 5:48PM",@"5:35PM - 6:30PM",@"6:30PM - 7:20PM",@"7:30PM - 8:15PM",@"8:30PM - 9:15PM", @"9:30PM - 10:15PM",@"11:50PM - 12:32PM"];
    tblData66MTCAM = @[@"7:00AM - 7:40AM", @"7:15AM - 7:55AM",@"8:00AM - 8:40AM",@"8:30AM - 9:05AM",@"9:00AM - 9:40AM",@"9:30AM - 10:05AM",@"10:00AM - 10:40AM",@"10:30AM- 10:05AM",@"11:30AM - 12:05AM"];
    tblData66MTCPM = @[@"12:30PM - 1:05PM", @"1:30PM - 2:05PM",@"2:00PM - 2:40PM",@"2:30PM - 3:05PM",@"3:00PM - 3:40PM",@"3:30PM - 4:05PM",@"4:00PM - 4:40PM",@"4:30PM - 5:05PM",@"5:00PM - 5:40PM",@"5:25PM - 6:05PM",@"5:55PM - 6:35PM",@"6:10PM - 6:50PM", @"6:25PM - 7:05PM",@"6:40PM - 7:20PM",@"6:55PM - 7:35PM",@"7:10PM - 7:45PM",@"7:30PM 8:05PM",@"8:30PM - 9:05PM",@"9:00PM - 9:35PM",@"10:15PM - 10:50PM",@"10:45PM - 11:20PM",@"12:00AM - 12:35AM"];
   
    //33 Weekdays
    tblData33NYCAM = @[@"5:30AM - 6:07AM", @"5:50AM - 6:27AM",@"5:50AM - 6:32AM",@"6:10AM - 6:47AM",@"6:20AM - 6:57AM",@"6:27AM - 7:09AM",@"6:27AM - 7:09AM",@"6:44AM - 7:26AM",@"6:50AM - 7:27AM",@"7:00AM - 7:37AM",@"7:02AM - 7:44AM",@"7:08AM - 7:57AM", @"7:08AM - 7:57AM",@"7:10AM - 7:47AM",@"7:20AM - 8:02AM",@"7:30AM - 8:07AM",@"7:35AM - 8:17AM",@"7:40AM - 8:17AM",@"7:50AM - 8:27AM",@"8:00AM - 8:37AM",@"8:10AM - 8:52AM",@"8:12AM - 8:52AM",@"8:25AM - 9:02AM", @"8:35AM - 9:17AM",@"8:45AM - 9:22AM",@"8:55AM - 9:37AM",@"9:15AM - 9:51AM",@"9:34AM - 10:16AM",@"10:00AM - 10:36AM",@"10:45AM - 11:21AM",@"11:45AM - 12:21AM"];
    tblData33NYCPM = @[@"12:45PM - 1:21PM", @"1:45PM - 2:21PM",@"2:12PM - 2:52PM",@"2:45PM - 3:45PM",@"3:12PM -3:52PM",@"3:45PM - 4:21PM",@"4:12PM - 4:52PM",@"4:45PM - 5:12PM",@"5:12PM - 5:52PM",@"5:45PM - 6:21PM",@"6:45PM - 7:20PM",@"7:49PM - 8:20PM", @"8:45PM - 9:20PM",@"9:45PM - 10:20PM",@"10:45PM - 11:20PM"];
    tblData33MTCAM = @[@"6:45AM - 7:19AM", @"7:30AM - 8:04AM",@"8:15AM - 8:49AM",@"8:45AM - 9:24AM",@"9:!5AM - 9:49AM",@"10:00AM - 10:35AM",@"11:00AM - 11:35AM",@"12:00PM - 12:35PM"];
    tblData33MTCPM = @[@"12:00PM - 12:35PM", @"1:00PM - 1:05PM",@"2:00PM - 2:35PM",@"2:45PM - 3:24PM",@"3:15PM - 3:50PM",@"3:50PM - 4:29PM",@"4:15PM - 4:50PM",@"4:40PM - 5:19PM",@"4:55PM - 5:30PM",@"5:00PM - 5:35PM",@"5:15PM - 5:50PM",@"5:20PM - 5:55PM", @"5:35PM - 6:10PM",@"5:35PM - 6:10PM",@"5:55PM - 6:30PM",@"5:55PM - 6:34PM",@"6:15PM - 6:50PM",@"6:15PM - 6:50PM",@"6:25PM - 7:04PM",@"6:35PM - 7:10PM",@"6:35PM - 7:10PM",@"6:55PM - 7:30PM",@"7:00PM - 7:39PM", @"7:15PM - 7:50PM",@"7:15PM - 7:50PM",@"7:35PM - 8:10PM",@"7:35PM - 8:10PM",@"8:00PM - 8:35PM",@"8:00PM - 8:39PM",@"8:30PM - 8:35PM",@"8:30PM - 9:05PM",@"9:00PM - 9:39PM",@"9:30PM - 10:05PM",@"9:30PM - 10:05PM",@"10:15PM - 11:10PM",@"10:45PM - 11:20PM",@"11:45PM - 12:20PM",@"12:45PM - 1:20PM"];
    
    //66 Weekends
    tblData66NYCAMWknd = @[@"7:30AM - 8:06AM",@"8:30AM - 9:06AM",@"9:30AM - 10:06AM",@"10:30AM - 11:06AM",@"11:30AM - 12:06AM"];
    tblData66NYCPMWknd = @[@"12:30PM - 1:06PM",@"1:30PM - 2:06PM",@"2:30PM - 3:06PM",@"3:30PM - 4:06PM",@"4:30PM - 5:06PM",@"5:30PM - 6:06PM",@"6:30PM - 7:06PM",@"7:30PM - 8:06PM",@"8:30PM - 9:06PM",@"9:30PM - 1006PM",@"10:30PM - 11:06PM",@"11:50PM - 12:26AM"];
    tblData66MTCAMWknd = @[@"8:30AM - 9:00AM",@"9:30AM - 10:00AM",@"10:30AM - 11:00AM",@"11:30AM - 12:30PM"];
    tblData66MTCPMWknd = @[@"12:30PM - 1:00PM",@"1:30PM - 2:00PM",@"2:30PM - 3:00PM",@"3:30PM - 4:00PM",@"4:30PM - 5:00PM",@"5:30PM - 6:00PM",@"6:30PM - 7:00PM",@"7:30PM - 8:00PM",@"8:30PM - 9:00PM",@"9:30PM - 10:00PM", @"10:45PM - 11:15PM", @"11:45PM - 12:15AM", @"12:45AM - 1:15AM"];
    
    //33 Weekends
    tblData33NYCAMWknd = @[@"6:45AM - 7:25AM",@"7:45AM - 8:25AM",@"8:45AM - 9:25AM",@"9:45AM - 10:25AM",@"10:45AM - 11:25AM"];
    tblData33NYCPMWknd = @[@"12:45PM - 1:25PM",@"1:45PM - 2:25PM",@"2:45PM - 3:25PM",@"3:45PM - 4:25PM",@"4:45PM - 5:25PM",@"5:45PM - 6:25PM",@"6:45PM - 7:30PM",@"7:45PM - 8:20PM",@"8:45PM - 9:20PM",@"9:45PM - 10:20PM",@"10:45PM - 11:20PM",@"12:00AM - 12:31AM"];
    tblData33MTCAMWknd = @[@"8:00AM - 8:35AM",@"9:00AM - 9:35AM",@"10:00AM - 10:35AM",@"11:00AM - 11:35AM"];
    tblData33MTCPMWknd = @[@"12:01PM - 1:35PM",@"1:00PM - 1:35PM",@"2:00PM - 2:35PM",@"3:00PM - 3:35PM",@"4:00PM - 4:35PM",@"5:00PM - 5:35PM",@"6:00PM - 6:35PM",@"7:00PM - 7:35PM",@"7:45PM - 8:19PM",@"8:30PM - 8:59PM",@"9:30PM - 9:59PM",@"10:45PM - 11:14PM",@"11:45PM - 12:16PM",@"12:45PM - 1:14PM"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"tableOutput"])
    {
        TableViewController *controller = [segue destinationViewController];
        NSLog(@"Go Button pressed");
        NSLog(@"iBus is %i", iBus);
        NSLog(@"iRoute is %i", iRoute);
        NSLog(@"iTime is %i", iTime);
        NSLog(@"iWeek is %i", iWeek);
        //33 toMtc AM Weekday
        if(iBus == 33 && iRoute == 1 && iTime == 0 && iWeek == 0)
        {
            NSLog(@"33 toMtc AM Weekdays");
            controller->tblData = tblData33MTCAM;
            controller->tblSectionName = @"#33 NYC to MTC AM Weekdays";
        }
        //33 toMtc PM Weekday
        else if(iBus == 33 && iRoute == 1 && iTime == 1 && iWeek == 0)
        {
            NSLog(@"33 toMtc PM Weekdays");
            controller->tblData = tblData33MTCPM;
            controller->tblSectionName = @"#33 NYC to MTC PM Weekdays";
        }
        //33 to NYC AM Weekday
        else if(iBus == 33 && iRoute == 0 && iTime == 0 && iWeek == 0)
        {
            NSLog(@"33 to NYC AM Weekdays");
            controller->tblData = tblData33NYCAM;
            controller->tblSectionName = @"#33 MTC to NYC AM Weekdays";
        }
        //33 to NYC PM Weekday
        else if(iBus == 33 && iRoute == 0 && iTime == 1 && iWeek == 0)
        {
            NSLog(@"33 to NYC PM Weekdays");
            controller->tblData = tblData33NYCPM;
            controller->tblSectionName = @"#33 MTC to NYC PM Weekdays";
        }
        //66 ToMtc AM Weekday
        else if(iBus == 66 && iRoute == 1 && iTime ==0 && iWeek == 0)
        {
            NSLog(@"66 ToMtc AM Weekdays");
            controller->tblData = tblData66MTCAM;
            controller->tblSectionName = @"#66 NYC to MTC AM Weekdays";
        }
        //66 ToMtc PM Weekday
        else if(iBus == 66 && iRoute == 1 && iTime == 1 && iWeek == 0)
        {
            NSLog(@"66 ToMtc PM Weekdays");
            controller->tblData = tblData66MTCPM;
            controller->tblSectionName = @"#66 NYC to MTC PM Weekdays";
        }
        //66 toNYC AM Weekday
        else if(iBus == 66 && iRoute == 0 && iTime == 0 && iWeek == 0)
        {
            NSLog(@"66 toNYC AM Weekdays");
            controller->tblData = tblData66NYCAM;
            controller->tblSectionName = @"#66 MTC to NYC AM Weekdays";

        }
        //66 toNYC PM Weekday
        else if(iBus == 66 && iRoute == 0 && iTime == 1 && iWeek == 0)
        {
            NSLog(@"66 toNYC PM Weekdays");
            controller->tblData = tblData66NYCPM;
            controller->tblSectionName = @"#66 MTC to NYC PM Weekdays";
        }
        //Weekends Below
        else if(iBus == 33 && iRoute == 1 && iTime == 0 && iWeek == 1)
        {
            NSLog(@"33 toMtc AM Weekends");
            controller->tblData = tblData33MTCAMWknd;
            controller->tblSectionName = @"#33 NYC to MTC AM Weekends";
        }
        //33 toMtc PM Weekends
        else if(iBus == 33 && iRoute == 1 && iTime == 1 && iWeek == 1)
        {
            NSLog(@"33 toMtc PM Weekends");
            controller->tblData = tblData33MTCPMWknd;
            controller->tblSectionName = @"#33 NYC to MTC PM Weekends";
        }
        //33 to NYC AM Weekends
        else if(iBus == 33 && iRoute == 0 && iTime == 0 && iWeek == 1)
        {
            NSLog(@"33 to NYC AM Weekends");
            controller->tblData = tblData33NYCAMWknd;
            controller->tblSectionName = @"#33 MTC to NYC AM Weekends";
        }
        //33 to NYC PM Weekends
        else if(iBus == 33 && iRoute == 0 && iTime == 1 && iWeek == 1)
        {
            NSLog(@"33 to NYC PM Weekends");
            controller->tblData = tblData33NYCPMWknd;
            controller->tblSectionName = @"#33 MTC to NYC PM Weekends";
        }
        //66 ToMtc AM Weekends
        else if(iBus == 66 && iRoute == 1 && iTime ==0 && iWeek == 1)
        {
            NSLog(@"66 ToMtc AM Weekends");
            controller->tblData = tblData66MTCAMWknd;
            controller->tblSectionName = @"#66 NYC to MTC AM Weekends";
        }
        //66 ToMtc PM Weekends
        else if(iBus == 66 && iRoute == 1 && iTime == 1 && iWeek == 1)
        {
            NSLog(@"66 ToMtc PM Weekends");
            controller->tblData = tblData66MTCPMWknd;
            controller->tblSectionName = @"#66 NYC to MTC PM Weekends";
        }
        //66 toNYC AM Weekends
        else if(iBus == 66 && iRoute == 0 && iTime == 0 && iWeek == 1)
        {
            NSLog(@"66 toNYC AM Weekends");
            controller->tblData = tblData66NYCAMWknd;
            controller->tblSectionName = @"#66 MTC to NYC AM Weekends";
            
        }
        //66 toNYC PM Weekends
        else if(iBus == 66 && iRoute == 0 && iTime == 1 && iWeek == 1)
        {
            NSLog(@"66 toNYC PM Weekends");
            controller->tblData = tblData66NYCPMWknd;
            controller->tblSectionName = @"#66 MTC to NYC PM Weekends";
        }
        
        
    }
}


- (IBAction)segBusTapped:(id)sender {
    //test code to see if its working
    if(_segBus.selectedSegmentIndex==0)
    {
        NSLog(@"Bus 33 selected");
        iBus = 33;
    }
    else if(_segBus.selectedSegmentIndex==1)
    {
        NSLog(@"Bus 66 selected");
        iBus = 66;
    }
    
}

- (IBAction)segRouteTapped:(id)sender {
    //test code to see if its working
    NSLog(@"Debug::Route selected as %li",(long)_segRoute.selectedSegmentIndex );
    if(_segRoute.selectedSegmentIndex==0)
    {
        NSLog(@"To NYC selected");
        iRoute = 0;
    }
    if(_segRoute.selectedSegmentIndex==1)
    {
        NSLog(@"To MTC selected");
        iRoute = 1;
    }
}

- (IBAction)segTimeTapped:(id)sender {
    //test code to see if its working
    if(_segTime.selectedSegmentIndex==0)
    {
        NSLog(@"AM selected");
        iTime = 0;
    }
    else if(_segTime.selectedSegmentIndex==1)
    {
        NSLog(@"PM selected");
        iTime = 1;
    }
    
}
- (IBAction)segWeekTapped:(id)sender {
    //test code to see if its working
    if(_segWeek.selectedSegmentIndex==0)
    {
        NSLog(@"Weekday selected");
        iWeek = 0;
    }
    else if(_segWeek.selectedSegmentIndex==1)
    {
        NSLog(@"Weekend selected");
        iWeek = 1;
    }
}


@end
