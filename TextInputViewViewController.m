//
//  TextInputViewViewController.m
//  DeCampV3
//
//  Created by Baker, James on 11/29/17.
//  Copyright © 2017 Baker, James. All rights reserved.
//

#import "TextInputViewViewController.h"

@interface TextInputViewViewController ()

@end

@implementation TextInputViewViewController

- (IBAction)FindBus:(id)sender
{
    //Check From Field input for the from location and the To location and return back the array for the table from the dictionary that has all the bus routes for that time period
}

/*-(void)placeTextBorder
{
    
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //$$TODO$$Bottom border setup $$TODO$$ should put this in a function where I pass in the variable anmes and get the otput done.
    //Bottom border FromField
    CALayer *bottomBorderFrom = [CALayer layer];
    bottomBorderFrom.frame = CGRectMake(0.0f, self.FromField.frame.size.height -1, self.FromField.frame.size.width, 1.0f);
    bottomBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [self.FromField.layer addSublayer:bottomBorderFrom];

    // Left border FromField
    CALayer *leftBorderFrom = [CALayer layer];
    leftBorderFrom.frame = CGRectMake(0.0f, 20.0f, 1.0f, self.FromField.frame.size.height-20);
    leftBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [self.FromField.layer addSublayer:leftBorderFrom];
    
    // Right border FromField
    CALayer *rightBorderFrom = [CALayer layer];
    rightBorderFrom.frame = CGRectMake(self.FromField.frame.size.width-1, 20.0f, 1.0f, self.FromField.frame.size.height-20);
    rightBorderFrom.backgroundColor = [UIColor blackColor].CGColor;
    [self.FromField.layer addSublayer:rightBorderFrom];
    
    //ToFields
    //Bottom border ToField
    CALayer *bottomBorderTo = [CALayer layer];
    bottomBorderTo.frame = CGRectMake(0.0f, self.ToField.frame.size.height -1, self.ToField.frame.size.width, 1.0f);
    bottomBorderTo.backgroundColor = [UIColor blackColor].CGColor;
    [self.ToField.layer addSublayer:bottomBorderTo];
    
    // Left border FromField
    CALayer *leftBorderTo = [CALayer layer];
    leftBorderTo.frame = CGRectMake(0.0f, 20.0f, 1.0f, self.ToField.frame.size.height-20);
    leftBorderTo.backgroundColor = [UIColor blackColor].CGColor;
    [self.ToField.layer addSublayer:leftBorderTo];
    
    // Right border FromField
    CALayer *rightBorderTo = [CALayer layer];
    rightBorderTo.frame = CGRectMake(self.ToField.frame.size.width-1, 20.0f, 1.0f, self.ToField.frame.size.height-20);
    rightBorderTo.backgroundColor = [UIColor blackColor].CGColor;
    [self.ToField.layer addSublayer:rightBorderTo];
    
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
