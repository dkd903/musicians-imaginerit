//
//  MNBSecondViewController.h
//  MusicNetBand
//
//  Created by Debjit Saha on 4/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBSecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *musicId;
@property (weak, nonatomic) IBOutlet UITextField *question;
- (IBAction)submitQuestion:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *questionIndicator;

@end
