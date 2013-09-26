//
//  DetailViewController.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

- (void)setImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.image = image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setImage:self.imageName];
}

@end
