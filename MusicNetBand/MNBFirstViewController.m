//
//  MNBFirstViewController.m
//  MusicNetBand
//
//  Created by Debjit Saha on 4/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "MNBFirstViewController.h"
#import "AFNetworking.h"
#import "MNBApiCreds.h"

@interface MNBFirstViewController ()
@property int first;
@property int last;
@end

@implementation MNBFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [_webViews loadRequest:request];
    _webViews.scrollView.scrollEnabled = TRUE;
    _webViews.scalesPageToFit = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextClick:(id)sender {
    
    //[_webViews stringByEvaluatingJavaScriptFromString:@"window.scrollTo(0.0, 100.0)"];
    _first += 500;
    _last += 600;
    _webViews.scrollView.contentOffset = CGPointMake(0, _last);
    

        
        //[_questionIndicator startAnimating];
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //NSInteger uid = [[_musicId text] integerValue];
    
        NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[[_musicId text] intValue] ]};
        AFHTTPRequestOperation *op = [manager POST:@"toNextCell" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            //[_questionIndicator stopAnimating];


            UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertViewE show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            //[_questionIndicator stopAnimating];

            UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertViewE show];
            
        }];
        
        [op start];
        
    
    
    
}
@end
