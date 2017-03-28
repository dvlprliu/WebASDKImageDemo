//
//  SecondViewController.m
//  WebASDKImageDemo
//
//  Created by Zhuang Liu on 28/03/2017.
//  Copyright © 2017 Cichang. All rights reserved.
//

#import "SecondViewController.h"
#import <WebASDKImageManager.h>

@interface SecondViewController () <ASNetworkImageNodeDelegate>

@property (nonatomic, strong) SDWebASDKImageManager *asdkManager;
@property (nonatomic, strong) NSURL *url;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = [NSURL URLWithString:@"http://wx1.sinaimg.cn/large/83f596c9gy1fe27pzqb8aj20xc0dlgnx.jpg"];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    SDWebASDKImageManager *asyncImageManager = [[SDWebASDKImageManager alloc] initWithWebImageManager:manager];
        asyncImageManager.webImageOptions = SDWebImageRetryFailed | SDWebImageCacheMemoryOnly;
    ASNetworkImageNode *node = [[ASNetworkImageNode alloc] initWithCache:asyncImageManager downloader:asyncImageManager];
    node.frame = self.view.bounds;
    node.URL = _url;
    node.delegate = self;
    [self.view addSubnode:node];
    

    
    self.asdkManager = asyncImageManager;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    [self.asdkManager cachedImageWithURL:_url callbackQueue:dispatch_get_main_queue() completion:^(id<ASImageContainerProtocol>  _Nullable imageFromCache) {
        // here should not be nil
        NSLog(@"%@", imageFromCache.asdk_image);
    }];
}


@end
