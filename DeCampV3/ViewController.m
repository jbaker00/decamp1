//
//  ViewController.m
//  DeCampV3
//
//  Created by Baker, James on 10/23/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //33 Bus
    NSString    const   *str66ToMtcAM;
    NSString    const   *str66ToMtcPM;
    NSString    const   *str33ToMtcAM;
    NSString    const   *str33ToMtcPM;
    
    //66 Bus
    NSString    const   *str66ToNycAM;
    NSString    const   *str66ToNycPM;
    NSString    const   *str33ToNycAM;
    NSString    const   *str33ToNycPM;
    
    //Variables for whats selected
    //Bool for the chosen bus 0 = 33 1 = 66
    int iBus;
    //Bool for the chosen route 0 = toNyc 1 = to MTC
    int iRoute;
    //Bool for the chosen time 0 = AM 1 = PM
    int iTime;
    
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize Data
    //33 Bus
    str66ToMtcAM = @"66 To MTC AM";
    str66ToMtcPM = @"66 To MTC PM";
    str33ToMtcAM = @"6:45AM     7:19AM";
    str33ToMtcPM = @"12:00PM    12:35PM";
    
    //66 Bus
    str66ToNycAM = @"66 To NYC AM";
    str66ToNycPM = @"66 To NYC PM";
    str33ToNycAM = @"5:30AM     6:07AM";
    str33ToNycPM = @"12:45PM    1:21PM";
   
    //Initialize the choice selections
    iRoute = 0;
    iBus = 0;
    iTime = 0;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (IBAction)Go:(id)sender {
    
    NSLog(@"Go Button pressed");

    //66 ToMtc AM str66ToMtcAM
    if(iBus ==1 && iRoute == 1 && iTime == 0)
    {
        NSLog(@"66 ToMtc AM str66ToMtcAM");
        _lblOutput.text = str66ToMtcAM;
    }
    //66 ToMtc PM str66ToMtcPM
    else if(iBus == 1 && iRoute == 1 && iTime == 1)
    {
        NSLog(@"66 ToMtc AM str66ToMtcPM");
        _lblOutput.text = str66ToMtcPM;
    }
    //66 toNYC AM str66ToNYCAM
    else if(iBus == 1 && iRoute == 0 && iTime == 0)
    {
        NSLog(@"66 toNYC AM str66ToNYCAM");
        _lblOutput.text = str66ToNycAM;
    }
    //66 toNYC PM str66ToNYCPM
    else if(iBus == 1 && iRoute == 0 && iTime == 1)
    {
        NSLog(@"66 toNYC PM str66ToNYCPM");
        _lblOutput.text = str66ToNycPM;
    }
    //33 toMtc AM strToMtcAM
    else if(iBus == 0 && iRoute == 1 && iTime == 0)
    {
        NSLog(@"33 toMtc AM strToMtcAM");
        _lblOutput.text = str33ToMtcAM;
    }
    //33 toMtc PM str33ToMtcPM
    else if(iBus == 0 && iRoute == 1 && iTime == 1)
    {
        NSLog(@"33 toMtc PM str33ToMtcPM");
        _lblOutput.text = str33ToMtcPM;
    }
    //33 to NYC AM str33ToNYCAM
    else if(iBus == 0 && iRoute == 0 && iTime == 0)
    {
        NSLog(@"/33 to NYC AM str33ToNYCAM");
        _lblOutput.text = str33ToNycAM;
    }
    //33 to NYC PM str33ToMtcPM
    else if(iBus == 0 && iRoute == 1 && iTime == 1)
    {
        NSLog(@"33 to NYC PM str33ToMtcPM");
        _lblOutput.text = str33ToMtcPM;
    }

    
}


- (IBAction)segBusTapped:(id)sender {
    //test code to see if its working
    if(_segBus.selectedSegmentIndex==0)
    {
        NSLog(@"Bus 33 selected");
        iBus = 0;
    }
    else if(_segBus.selectedSegmentIndex==1)
    {
        NSLog(@"Bus 66 selected");
        iBus = 1;
    }
    
}

- (IBAction)segRouteTapped:(id)sender {
    //test code to see if its working
    if(_segRoute.selectedSegmentIndex==0)
    {
        NSLog(@"To NYC selected");
        iRoute = 0;
    }
    else if(_segBus.selectedSegmentIndex==1)
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


@end
