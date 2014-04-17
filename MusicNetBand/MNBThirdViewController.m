//
//  MNBThirdViewController.m
//  MusicNetBand
//
//  Created by Debjit Saha on 4/14/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "MNBThirdViewController.h"
#import "AFNetworking.h"
#import "MNBApiCreds.h"

@interface MNBThirdViewController ()

@end

@implementation MNBThirdViewController

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
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getVotes:(id)sender {
    
    if([[_musicId text] length] == 0 ) {
        
        UIAlertView *newAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in All Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [newAlert show];
        
    } else {
        
        [_votesINdicator startAnimating];
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[[_musicId text] intValue] ]};
        AFHTTPRequestOperation *op = [manager POST:@"getVotes" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            [_votesINdicator stopAnimating];
            //[_votesField setText:<#(NSString *)#>]
            UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertViewE show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            [_votesINdicator stopAnimating];
            
            UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertViewE show];
            
        }];
        
        [op start];
        
    }
}
@end
