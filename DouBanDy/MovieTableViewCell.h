//
//  MovieTableViewCell.h
//  DouBanDy
//
//  Created by peter on 14-8-11.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moviePointsLabel;

@end
