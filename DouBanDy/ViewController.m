//
//  ViewController.m
//  DouBanDy
//
//  Created by peter on 14-8-7.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MovieTableViewCell.h"
#import "MovieViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (id) init
{
    //调用父类的指定初始化方法
    //self = [super initWithStyle:UITableViewStyleGrouped];
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
//        
//        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPossession:)];
//        
//        [[self navigationItem] setRightBarButtonItem:bbi];
//        [[self navigationItem] setTitle:@"Homepwner"];
//        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
        
    }
    
    // NSLog(@"sum count %d",[[[PossessionStore defaultStore] allPossessions] count]);
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // loading = [[UIActivityIndicatorView alloc] init];
    [loading startAnimating];
    [loading setHidesWhenStopped:YES];
    
    
    NSString* movieUrl = @"https://api.douban.com/v2/movie/us_box";
    self.title = @"豆瓣电影";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:movieUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* data = (NSDictionary*)responseObject;
        movieData = data[@"subjects"];
        movieDate = data[@"date"];
        
        [loading stopAnimating];
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [movieData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell* movieCell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    if (!movieCell) {
        movieCell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"movieCell"];
    }
    
    NSString* imageUrl = nil;
    NSNumber* points = nil;
    
    if ([movieData count] > 0) {
        NSDictionary* movie = movieData[indexPath.row];
        if (movie[@"subject"] != nil ) {
            movieCell.movieTitleLabel.text = movie[@"subject"][@"title"];
            imageUrl = movie[@"subject"][@"images"][@"small"];
            points = movie[@"subject"][@"rating"][@"average"];
        }else{
            movieCell.movieTitleLabel.text = movie[@"title"];
            imageUrl = movie[@"images"][@"small"];
            points = movie[@"rating"][@"average"];
        }
        
        NSNumberFormatter* formatter =  [[NSNumberFormatter alloc] init];
        movieCell.moviePointsLabel.text = [[formatter stringFromNumber:points] stringByAppendingString:@"分"];
        NSURL* url = [NSURL URLWithString:imageUrl];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage* image = [UIImage imageWithData:data];
            [self->imageArray arrayByAddingObject:image];
            movieCell.movieImageView.image = image;
            
        }];
        
    }
    
    return movieCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30L;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"北美电影票房榜";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    MovieViewController* movieView = segue.destinationViewController;
    
    NSDictionary* movie = movieData[indexPath.row];
    movieView.movieTitle = movie[@"subject"][@"title"];
    movieView.imageUrl = movie[@"subject"][@"images"][@"large"];
    movieView.movieId = movie[@"subject"][@"id"];

}

//search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searching");
    
    NSString* movieUrl = @"https://api.douban.com/v2/movie/search";
    NSString* q = searchBar.text;
    NSDictionary *parameters = @{@"q": q};
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:movieUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* data = (NSDictionary*)responseObject;
        movieData = data[@"subjects"];
  //      movieDate = movieData[@"date"];
        
       // [loading stopAnimating];
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


@end
