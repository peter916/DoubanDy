//
//  MovieViewController.h
//  DouBanDy
//
//  Created by peter on 14-8-12.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *moviePostView;

@property (retain,nonatomic)NSString* imageUrl;
@property (retain,nonatomic)NSString* movieTitle;
@property (retain,nonatomic)NSString* movieId;
@property (retain,nonatomic)NSDictionary* movieSubject;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (weak, nonatomic) IBOutlet UITextView *summaryView;
@end
