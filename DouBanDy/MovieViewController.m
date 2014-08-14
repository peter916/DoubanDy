//
//  MovieViewController.m
//  DouBanDy
//
//  Created by peter on 14-8-12.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//
#import "AFNetworking.h"
#import "MovieViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_loading startAnimating];
    [_loading setHidesWhenStopped:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self->_movieTitle;
    NSURL* url = [NSURL URLWithString:self->_imageUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        UIImage* image = [UIImage imageWithData:data];
        self.moviePostView.image = image;
        [_loading stopAnimating];
        
    }];
    
    NSString* movieUrl = [@"https://api.douban.com/v2/movie/subject/" stringByAppendingString:self.movieId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:movieUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.movieSubject = (NSDictionary*)responseObject;
        self.summaryView.text = self.movieSubject[@"summary"];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
