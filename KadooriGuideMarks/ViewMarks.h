//
//  ViewMarks.h
//  KadooriGuideMarks
//
//  Created by Moja on 1/3/16.
//  Copyright © 2016 MicroFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
@import GoogleMobileAds;

@interface ViewMarks : UIViewController  <UITableViewDelegate, UITableViewDataSource>


@property NSString* stdNum;
@property NSString* stdPass;
@property (strong, nonatomic) IBOutlet GADBannerView *myBanner;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *loaderImgg;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
