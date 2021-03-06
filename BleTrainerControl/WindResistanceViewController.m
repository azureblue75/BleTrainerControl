//
//  WindResistanceViewController.m
//  BleTrainerControl
//
//  Created by William Minol on 03/09/2015.
//  Copyright (c) 2015 Kinomap. All rights reserved.
//

#import "WindResistanceViewController.h"

#import "AppDelegate.h"

@interface WindResistanceViewController ()

@end

@implementation WindResistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [windResistanceCoefficientSlider setMinimumValue:0.0];
    [windResistanceCoefficientSlider setMaximumValue:1.86];
    
    [windSpeedSlider setMinimumValue:-127.0];
    [windSpeedSlider setMaximumValue:127.0];
    
    [draftingFactorSlider setMinimumValue:0.0];
    [draftingFactorSlider setMaximumValue:1.0];
    
    //Default values
    [windResistanceCoefficientSlider setValue:0.6];
    [windSpeedSlider setValue:0.0];
    [draftingFactorSlider setValue:0.0];
    
    //Display values
    [self onSliderValueChanged:windResistanceCoefficientSlider];
    [self onSliderValueChanged:windSpeedSlider];
    [self onSliderValueChanged:draftingFactorSlider];
    
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseButton:)] autorelease]];
    
    Utils *utils = [[[Utils alloc] init] autorelease];
    NSArray *buttonsArray = [NSArray arrayWithObjects:sendButton, nil];
    for(UIButton *btn in buttonsArray)
    {
        [btn setBackgroundImage:[utils imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[utils imageWithColor:[UIColor colorWithRed:76./255. green:164./255. blue:223./255. alpha:1.0]] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onCloseButton:(id)sender
{
    [super dismissViewControllerAnimated:TRUE completion:nil];
}

-(IBAction)onSendButton:(id)sender
{
    //Send for wind resistanc mode
    float windResistanceCoefficientValue = windResistanceCoefficientSlider.value;
    float windSpeedValue = windSpeedSlider.value;
    float draftingFactorValue = draftingFactorSlider.value;
    
    [appDelegate.btleTrainerManager sendWindResistanceCoefficient:windResistanceCoefficientValue windSpeed:windSpeedValue draftingFactor:draftingFactorValue];
}


-(IBAction)onSliderValueChanged:(id)sender
{
    if([sender isEqual:windResistanceCoefficientSlider])
        [windResistanceCoefficientValueLabel setText:[NSString stringWithFormat:@"%0.2f kg/m", windResistanceCoefficientSlider.value]];
    
    if([sender isEqual:windSpeedSlider])
        [windSpeedValueLabel setText:[NSString stringWithFormat:@"%0.0f km/h", windSpeedSlider.value]];
    
    if([sender isEqual:draftingFactorSlider])
        [draftingFactorValueLabel setText:[NSString stringWithFormat:@"%0.2f", draftingFactorSlider.value]];
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
