//
//  ViewController.h
//  KadooriGuideMarks
//
//  Created by Moja on 1/3/16.
//  Copyright © 2016 MicroFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ViewMarks.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    Reachability *internetReachableFoo;
}

@property (strong, nonatomic) IBOutlet UIImageView *btnInfo;
@property (strong, nonatomic) IBOutlet UITextField *txtNum;
@property (strong, nonatomic) IBOutlet UITextField *txtPass;
@property (strong, nonatomic) IBOutlet UIButton *btnEnter;


+(void) showMessage:(NSString *)message;

@end

