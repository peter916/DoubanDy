//
//  ViewController.m
//  DouBanDy
//
//  Created by peter on 14-8-7.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

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
    self.title = @"北美电影票房榜";
    NSString* movieUrl = @"https://api.douban.com/v2/movie/us_box";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:movieUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        movieData = (NSDictionary*)responseObject;
        movieData = responseObject;
        movieSum = [movieData[@"subjects"] count];
        [self.tableView reloadData];
        
         NSLog(@"JSON: %d", movieSum);
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
    return movieSum;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* movieCell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    if (!movieCell) {
        movieCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"movieCell"];
    }
    
    if (movieSum > 0) {
        NSDictionary* movie = movieData[@"subjects"][indexPath.row];
        movieCell.textLabel.text = movie[@"title"];
    }
    
    return movieCell;
    
}






@end
