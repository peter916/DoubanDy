//
//  ViewController.h
//  DouBanDy
//
//  Created by peter on 14-8-7.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UISearchBarDelegate>
{
    NSArray* movieData;
    NSInteger movieSum;
    NSArray* imageArray;
    NSString* movieDate;

    __weak IBOutlet UIActivityIndicatorView *loading;
}

@end
