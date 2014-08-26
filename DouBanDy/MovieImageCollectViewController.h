//
//  MovieImageCollectViewController.h
//  DouBanDy
//
//  Created by peter on 14-8-25.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieImageCollectViewController : UICollectionViewController
{
    NSArray* movieData;
}
@property (retain,nonatomic)NSString* movieId;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
