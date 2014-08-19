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
    NSDictionary* movieData;
    NSInteger movieSum;
    NSArray* imageArray;
    NSString* movieDate;

    __weak IBOutlet UIActivityIndicatorView *loading;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
