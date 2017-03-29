//
//  GalleryViewController.m
//  TaskZennex
//
//  Created by Artem Makarov on 27.03.17.
//  Copyright © 2017 Artem Makarov. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryDownloader.h"
#import "GalleryModel.h"

@interface GalleryViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.alpha = 0.7;

    
    [self readDataFromJSON];

    CGRect scrollViewRect = self.view.bounds;
    
    self.galleryScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    self.galleryScrollView.pagingEnabled = YES;
    [self.galleryScrollView setAlwaysBounceVertical:NO];
    
    for (int i = 0; i < self.galleryArray.count; i++) {
        
        GalleryModel *model = [self.galleryArray objectAtIndex:i];
        
        CGFloat frameOrigin = i * self.view.frame.size.width;
        CGRect frameImageView = CGRectMake(frameOrigin, 20, self.view.frame.size.width, self.view.frame.size.height);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                ^{
                    NSURL *url = [NSURL URLWithString:model.sourceImageString];
                    NSData *data = [NSData dataWithContentsOfURL:url];
        
        dispatch_sync(dispatch_get_main_queue(), ^{

                    self.galleryImageView = [[UIImageView alloc] initWithFrame:frameImageView];
                                       
                    self.galleryImageView.image = [UIImage imageWithData:data];
                    self.galleryImageView.contentMode = UIViewContentModeScaleAspectFit;
            
                    [self.galleryScrollView addSubview:self.galleryImageView];
                });
                                   
        });
        
    }
    
    CGSize galleryScrollViewSize = CGSizeMake(scrollViewRect.size.width * self.galleryArray.count, scrollViewRect.size.height);
    
    self.galleryScrollView.backgroundColor = [UIColor clearColor];
    self.galleryScrollView.contentSize = galleryScrollViewSize;

    [self.view addSubview:self.galleryScrollView];
    self.galleryScrollView.delegate = self;
    [self.galleryScrollView setMaximumZoomScale:5.0f];
    [self.galleryScrollView setBounces:YES];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.nextButton];
}

//Метод для отключения каких-либо действий пользователем, пока не произойдёт смена картинки
- (void)ignoringInteractionEvents
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

//Метод для чтения даннх которые приходят с JSON файла
- (void)readDataFromJSON
{
    GalleryDownloader *galleryDownloader = [GalleryDownloader parserManager];
    self.galleryArray = [galleryDownloader parsingJSON];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

//Метод для кнопки предыдущая картинка
- (IBAction)backButtonAction:(UIButton *)sender
{
    if (self.galleryScrollView.contentOffset.x >= self.galleryScrollView.frame.size.width) {
        CGRect frame;
        frame.origin.x = self.galleryScrollView.contentOffset.x -self.galleryScrollView.frame.size.width;
        frame.origin.y = 0;
        frame.size = self.galleryScrollView.frame.size;
        [self.galleryScrollView scrollRectToVisible:frame animated:YES];
    }
    
    [self ignoringInteractionEvents];
}
//Метод для кнопки следующая картинка
- (IBAction)nextButtonAction:(UIButton *)sender
{
    if (self.galleryScrollView.contentOffset.x < (self.galleryScrollView.frame.size.width * self.galleryArray.count)) {
        CGRect frame;
        frame.origin.x = self.galleryScrollView.contentOffset.x +self.galleryScrollView.frame.size.width;
        frame.origin.y = 0;
        frame.size = self.galleryScrollView.frame.size;
        [self.galleryScrollView scrollRectToVisible:frame animated:YES];
    }
    
    [self ignoringInteractionEvents];
}

- (IBAction)backBarButtonAction:(UIBarButtonItem *)sender
{
    [self backButtonAction:self.backButton];
}

- (IBAction)nextBarButtonAction:(UIBarButtonItem *)sender
{
    [self nextButtonAction:self.nextButton];
}


@end
