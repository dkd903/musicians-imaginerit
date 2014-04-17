//
//  MNBSecondViewController.m
//  MusicNetBand
//
//  Created by Debjit Saha on 4/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "MNBSecondViewController.h"
#import "AFNetworking.h"
#import "MNBApiCreds.h"

@interface MNBSecondViewController ()

@end

@implementation MNBSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitQuestion:(id)sender {
    
    if([[_question text] length] == 0 || [[_musicId text] length] == 0) {
        
        UIAlertView *newAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in All Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [newAlert show];
        
    } else {
        
        [_questionIndicator startAnimating];
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
       
        
        NSDictionary *parameters = @{@"newQuestion": [_question text], @"musicianId": [NSNumber numberWithInt:[[_musicId text] intValue] ]};
        AFHTTPRequestOperation *op = [manager POST:@"setNewQuestion" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            [_questionIndicator stopAnimating];
            [_question setText:@""];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Question Has Been Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertViewE show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            [_questionIndicator stopAnimating];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot Add Question" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertViewE show];
            
        }];
        
        [op start];
        
    }
    
}
@end
