//
//  MNBFirstViewController.h
//  MusicNetBand
//
//  Created by Debjit Saha on 4/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *musicId;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *nextCellIndicator;
@property (weak, nonatomic) IBOutlet UILabel *musicianIdentifierLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *questionIndicator;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property NSArray *musicianQuestions;
- (IBAction)nextClick:(id)sender;
@end
