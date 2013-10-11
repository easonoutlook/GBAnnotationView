//
//  AttackOptions.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-11.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "AttackOptions.h"

@interface AttackOptions()

@property (weak, nonatomic) IBOutlet UIButton *attackButton;
@property (weak, nonatomic) IBOutlet UIButton *nukeButton;

@end

@implementation AttackOptions

- (IBAction)nukeAction:(id)sender {
    NSString *message = @"It's the only way to be sure.";
    if (self.target) {
        message = [message stringByAppendingString:[NSString stringWithFormat:@"\n%@", self.target]];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nuke'em from orbit"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Ok", nil];
    [alert show];
}


- (IBAction)attackAction:(id)sender {
    NSString *who = self.target ?: @"the monster";
    NSString *message = [NSString stringWithFormat:@"Attack %@ with conventional forces", who];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send in the Army"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Ok", nil];
    [alert show];
}

@end
