//
//  PhotoViewController.h
//  DouBanDy
//
//  Created by peter on 14-8-26.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (retain,nonatomic)NSString* photoUrl;
@property (retain,nonatomic)NSString* castName;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@end
