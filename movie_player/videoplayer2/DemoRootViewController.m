//
//  RootViewController.m
//  VKVideoPlayer
//
//  Created by Matsuo, Keisuke | Matzo | TRVDD on 4/20/14.
//  Copyright (c) 2014 Viki Inc. All rights reserved.
//

#import "DemoRootViewController.h"
#import "VKVideoPlayerViewController.h"
#import "DemoVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import "AFHTTPClient.h"

typedef enum {
  DemoVideoPlayerIndexDefaultViewController = 0,
  DemoVideoPlayerIndexCustomViewController,
  DemoVideoPlayerIndexLength,
} DemoVideoPlayerIndex;

@interface DemoRootViewController ()
{
    NSMutableArray * LocalMovieList;
    NSMutableArray * LocalMovie_URL;
    NSMutableArray * MovieList;
    NSMutableArray * Movie_URL;
}
@end

@implementation DemoRootViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
  }
    LocalMovieList = [[NSMutableArray alloc]initWithObjects:@"jinganglang", nil];
    LocalMovie_URL = [[NSMutableArray alloc]initWithObjects:@"http://localhost:12345/jinganglang.mp4", nil];
    MovieList = [[NSMutableArray alloc]initWithObjects:@"jinganglang", nil];
    Movie_URL = [[NSMutableArray alloc]initWithObjects:@"http://localhost:12345/jinganglang.mp4", nil];
  return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    
}
-(void)viewDidLoad
{
    [self get_movie_list];
}
-(void)get_movie_list{
    NSString * url = GET_MOVIE_LIST_URL;
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setObject:@"get_movie_list" forKey:@"action"];
    AFHTTPClient * httpclien = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    httpclien.parameterEncoding = AFJSONParameterEncoding;
    [httpclien setDefaultHeader:@"Accept" value:@"test/json"];
    [httpclien postPath:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",responseDic);
        MovieList = LocalMovieList;
        Movie_URL = LocalMovie_URL;
        NSMutableArray * remote_movielist = [responseDic objectForKey:@"movie_list"];
        for(int i = 0; i < remote_movielist.count; i ++)
        {
            [MovieList addObject:remote_movielist[i]];
            [Movie_URL addObject:[NSString stringWithFormat:@"%@%@",MOVIE_PLAY_URL,remote_movielist[i]]];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClinet Error]: %@", error);
    }];
    //[self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [MovieList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellIdentifier = @"DemoRootTableCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
    cell.textLabel.text = MovieList[indexPath.row];
    /*
  switch (indexPath.row) {
    case DemoVideoPlayerIndexDefaultViewController:
      cell.textLabel.text = [NSString stringWithFormat:@"%@", [VKVideoPlayerViewController class]];
      break;
    case DemoVideoPlayerIndexCustomViewController:
      cell.textLabel.text = [NSString stringWithFormat:@"%@", [DemoVideoPlayerViewController class]];
      break;
  }
     */
  
  return cell;
}

- (VKVideoPlayerCaption*)testCaption:(NSString*)captionName {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:captionName ofType:@"srt"];
  NSData *testData = [NSData dataWithContentsOfFile:filePath];
  NSString *rawString = [[NSString alloc] initWithData:testData encoding:NSUTF8StringEncoding];
  
  VKVideoPlayerCaption *caption = [[VKVideoPlayerCaptionSRT alloc] initWithRawString:rawString];
  return caption;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    NSLog(@"%@ %@",Movie_URL[indexPath.row], MovieList[indexPath.row]);
    DemoVideoPlayerViewController * view = [[DemoVideoPlayerViewController alloc]initWithURL:Movie_URL[indexPath.row]];
    [self presentModalViewController:view animated:YES];
    /*
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  Class vcClass = NSClassFromString(cell.textLabel.text);
  UIViewController *viewController = [[vcClass alloc] init];
  
  [self presentModalViewController:viewController animated:YES];
  
  if ([viewController isKindOfClass:[VKVideoPlayerViewController class]]) {
    VKVideoPlayerViewController *videoController = (VKVideoPlayerViewController*)viewController;
    [videoController playVideoWithStreamURL:[NSURL URLWithString:@"http://localhost:12345/ios_240.m3u8"]];
    [videoController setSubtitle:[self testCaption:@"testCaptionBottom"]];
    
    [videoController.player setCaptionToTop:[self testCaption:@"testCaptionTop"]];
  }*/
}

@end
