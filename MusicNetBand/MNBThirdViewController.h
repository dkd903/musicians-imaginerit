//
//  MNBThirdViewController.h
//  MusicNetBand
//
//  Created by Debjit Saha on 4/14/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBThirdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *musicId;
- (IBAction)getVotes:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *votesField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *votesINdicator;

@end
