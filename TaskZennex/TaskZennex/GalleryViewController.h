//
//  GalleryViewController.h
//  TaskZennex
//
//  Created by Artem Makarov on 27.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController

@property (strong, nonatomic) NSArray *galleryArray;

@property (strong, nonatomic) IBOutlet UIScrollView *galleryScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *galleryImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;

- (IBAction)backButtonAction:(UIButton *)sender;
- (IBAction)nextButtonAction:(UIButton *)sender;

- (void)readDataFromJSON;
- (void)ignoringInteractionEvents;

@end
