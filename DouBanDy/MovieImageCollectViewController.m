//
//  MovieImageCollectViewController.m
//  DouBanDy
//
//  Created by peter on 14-8-25.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//
#import "AFNetworking.h"
#import "MovieImageCollectViewController.h"
#import "MovieCollectionViewCell.h"
#import "PhotoViewController.h"

@interface MovieImageCollectViewController ()

@end

@implementation MovieImageCollectViewController

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
    
    //[self.collectionView registerClass :[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"moviePhoto"];
   // NSLog(self.movieId);
    
    self.title = @"剧照";
    [_loading startAnimating];
    [_loading setHidesWhenStopped:YES];
    
    NSString* movieUrl = [@"https://api.douban.com/v2/movie/subject/" stringByAppendingString:self.movieId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:movieUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* movieSubject = (NSDictionary*)responseObject;
        movieData = movieSubject[@"casts"];
        //  self.summaryView.text = self.movieSubject[@"summary"];
        [self.collectionView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [_loading stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell* movieCell = (MovieCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"moviePhoto" forIndexPath:indexPath];
    
    if ([movieData count] > 0) {
        
        NSDictionary* photo = movieData[indexPath.row];
        movieCell.castLabel.text = photo[@"name"];
       // NSLog(photo[@"id"]);
        
        NSURL* url = [NSURL URLWithString:photo[@"avatars"][@"small"]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage* image = [UIImage imageWithData:data];
            movieCell.movieImageCell.image = image;
            
        }];
        
    }
    
    
    return movieCell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [movieData count];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PhotoViewController* photoView = segue.destinationViewController;
    NSDictionary* photo = movieData[indexPath.row];
    photoView.photoUrl = photo[@"avatars"][@"large"];
    photoView.castName = photo[@"name"];
    
}


@end
