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
    //Variables for whats selected
    //int for the chosen bus 33 or 66
    int iBus;
    //int for the chosen route 0 = toNyc 1 = to MTC
    int iRoute;
    //int for the chosen time 0 = AM 1 = PM
    int iTime;
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
    NSLog(@"iBus is %i", iBus);
    NSLog(@"iRoute is %i", iRoute);
    NSLog(@"iTime is %i", iTime);
    //33 toMtc AM
    if(iBus == 33 && iRoute == 1 && iTime == 0)
    {
        NSLog(@"33 toMtc AM");
        [self performSegueWithIdentifier:@"seg33ToMtcAM" sender:self];
    }
    //33 toMtc PM
    else if(iBus == 33 && iRoute == 1 && iTime == 1)
    {
        NSLog(@"33 toMtc PM");
        [self performSegueWithIdentifier:@"seg33ToMtcPM" sender:self];
    }
    //33 to NYC AM
    else if(iBus == 33 && iRoute == 0 && iTime == 0)
    {
        NSLog(@"33 to NYC AM");
        [self performSegueWithIdentifier:@"seg33ToNycAM" sender:self];
    }
    //33 to NYC PM
    else if(iBus == 33 && iRoute == 0 && iTime == 1)
    {
        NSLog(@"33 to NYC PM");
        [self performSegueWithIdentifier:@"seg33ToMtcPM" sender:self];
    }
    //66 ToMtc AM
    else if(iBus == 66 && iRoute == 1 && iTime ==0)
    {
        NSLog(@"66 ToMtc AM");
        [self performSegueWithIdentifier:@"seg66ToMtcAM" sender:self];
    }
        
    //66 ToMtc PM
    else if(iBus == 66 && iRoute == 1 && iTime == 1)
    {
        NSLog(@"66 ToMtc PM");
        [self performSegueWithIdentifier:@"seg66ToMtcPM" sender:self];
    }
    //66 toNYC AM
    else if(iBus == 66 && iRoute == 0 && iTime == 0)
    {
        NSLog(@"66 toNYC AM ");
        [self performSegueWithIdentifier:@"seg66ToNycAM" sender:self];

    }
    //66 toNYC PM
    else if(iBus == 66 && iRoute == 0 && iTime == 1)
    {
        NSLog(@"66 toNYC PM");
        [self performSegueWithIdentifier:@"seg66ToNycPM" sender:self];
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


@end
