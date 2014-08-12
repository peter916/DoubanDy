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
    
    NSString* movieUrl = @"https://api.douban.com/v2/movie/us_box";
    self.title = @"北美电影票房榜";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:movieUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        movieData = (NSDictionary*)responseObject;
        self.title = [@"北美电影票房榜" stringByAppendingString:movieData[@"date"]	];
        
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
    return [movieData[@"subjects"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell* movieCell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    if (!movieCell) {
        movieCell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"movieCell"];
    }
    
    if ([movieData[@"subjects"] count] > 0) {
        NSDictionary* movie = movieData[@"subjects"][indexPath.row];
        movieCell.movieTitleLabel.text = movie[@"subject"][@"title"];
        NSString* imageUrl = movie[@"subject"][@"images"][@"small"];
        NSNumber* points = movie[@"subject"][@"rating"][@"average"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    MovieViewController* movieView = segue.destinationViewController;
    
    NSDictionary* movie = movieData[@"subjects"][indexPath.row];
    movieView.movieTitle = movie[@"subject"][@"title"];
    movieView.imageUrl = movie[@"subject"][@"images"][@"large"];

}





@end
