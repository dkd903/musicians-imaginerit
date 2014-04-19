//
//  MNBWelcomeViewController.m
//  MusicNetBand
//
//  Created by Debjit Saha on 4/17/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "MNBWelcomeViewController.h"
#import "MNBFirstViewController.h"
#import "MNBApiCreds.h"
#import "AFNetworking.h"

@interface MNBWelcomeViewController ()

@end

@implementation MNBWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_musicianId setFrame:CGRectMake(180, 450, 400, 250)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MNBFirstViewController *targetVC = (MNBFirstViewController*)segue.destinationViewController;
    targetVC.musicId = [_musicianId text];
}

#pragma mark - Sender

- (IBAction)continueButton:(id)sender {
    NSString *musicianId = [_musicianId text];
    [musicianId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ];
    if ([musicianId length] == 0) {
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter Musician's ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertViewE show];
    } else if ([[_musicianId text] intValue] > 6 || [[_musicianId text] intValue] < 1) {
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Musician's ID cannot be greater than 6" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertViewE show];
    } else {
        [self performSegueWithIdentifier:@"SegueToMain" sender:self];
    }
}
@end
