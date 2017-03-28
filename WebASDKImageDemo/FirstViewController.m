//
//  FirstViewController.m
//  WebASDKImageDemo
//
//  Created by Zhuang Liu on 28/03/2017.
//  Copyright © 2017 Cichang. All rights reserved.
//

#import "FirstViewController.h"
#import <WebASDKImageManager.h>

@interface FirstViewController () <ASNetworkImageNodeDelegate>

@property (nonatomic, strong) NSURL *url;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = [NSURL URLWithString:@"http://wx3.sinaimg.cn/large/83f596c9gy1fe27pyto8dj20xc0m8wn8.jpg"];
    ASNetworkImageNode *node = [[ASNetworkImageNode alloc] initWithWebImage];
    node.frame = self.view.bounds;
    node.URL = _url;
    node.shouldCacheImage = YES;
    node.delegate = self;
    [self.view addSubnode:node];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    SDWebImageManager *webImageManager = [SDWebImageManager sharedManager];
    NSString *cacheKey = [webImageManager cacheKeyForURL:_url];
    [webImageManager.imageCache queryCacheOperationForKey:cacheKey done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
        // here should not be nil
        NSLog(@"image: %@, data: %@, cacheType: %@", image, data, @(cacheType));
    }];
}


@end
