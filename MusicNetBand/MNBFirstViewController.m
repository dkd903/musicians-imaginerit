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
    NSLog(@"MSIC ID - %@", _musicId);
        _musicianQuestions = [NSArray arrayWithObjects:@"If you could live anywhere on earth, where would you live?",
                    @"If you could choose your last meal, what would it be?",
                    @"Would you rather be rich and ugly, or poor and good looking?",
                    @"Who was the last person that you called or texted?",
                    @"What kind of old person do you want to grow up to become?",
                    @"How do you like your eggs cooked?",
                    @"Would you rather be the most popular kid in school or the smartest kid in school?",
                    @"How long does it take for you to get ready in the morning?", nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_musicianIdentifierLabel setText:_musicId];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showVotes) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextClick:(id)sender {
    [_nextCellIndicator startAnimating];
    //NSLog(@"ggg %@", _musicId);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"toNextCell" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_nextCellIndicator stopAnimating];
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertViewE show];
        [_cellLabel setText:[responseObject[@"cellNumber"] stringValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        [_nextCellIndicator stopAnimating];
        UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertViewE show];
    }];
    [op start];
}

- (void)showVotes {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"getVotes" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_voteLabel setText:operation.responseString];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        [_voteLabel setText:responseObject[@"votesPercent"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
    }];
    [op start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)[_musicianQuestions count]);
    return [_musicianQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    NSLog(@"%@", @"jjj");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_musicianQuestions objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%@",[_musicianQuestions objectAtIndex:indexPath.row]);
    
    [_questionIndicator startAnimating];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMNapiUrl]];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    NSDictionary *parameters = @{@"newQuestion": [_musicianQuestions objectAtIndex:indexPath.row], @"musicianId": [NSNumber numberWithInt:[_musicId intValue] ]};
    AFHTTPRequestOperation *op = [manager POST:@"setNewQuestion" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [_questionIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Question Has Been Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        [_questionIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot Add Question" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        //UIAlertView *alertViewE = [[UIAlertView alloc] initWithTitle:@"Response" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alertViewE show];
        
    }];
    
    [op start];
    
}

@end
