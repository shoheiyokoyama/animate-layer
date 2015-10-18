//
//  ShimmerViewController.m
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/18.
//  Copyright © 2015年 Shohei. All rights reserved.
//

#import "ShimmerViewController.h"
#import <FBShimmeringView.h>

@interface ShimmerViewController ()

@end

@implementation ShimmerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:shimmeringView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"Shimmer", nil);
    shimmeringView.contentView = loadingLabel;
    
    // Start shimmering.
    shimmeringView.shimmering = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
