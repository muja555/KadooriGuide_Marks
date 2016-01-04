//
//  ViewController.m
//  KadooriGuideMarks
//
//  Created by Moja on 1/3/16.
//  Copyright © 2016 MicroFuture. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL hasAppeared;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hasAppeared  = NO;
    
    //info button
    UILongPressGestureRecognizer *aboutRego = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressInfo:)];
    aboutRego.minimumPressDuration = .001;
    [self.btnInfo setMultipleTouchEnabled:YES];
    [self.btnInfo setUserInteractionEnabled:YES];
    [self.btnInfo addGestureRecognizer:aboutRego];
    
    
    //add to max number student
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitTextField:) name:@"UITextFieldTextDidChangeNotification" object:self.txtNum];
    
    self.txtPass.delegate = self;
    
    //TESTTTTTSST
//    self.txtNum.text = @"201410327";
//    self.txtPass.text = @"0598569854love";
    //=======
}


//info
- (void) longPressInfo:(UILongPressGestureRecognizer  *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSURL* url =[NSURL URLWithString:@"https://facebook.com/kadoori.guide"];
        [[UIApplication sharedApplication] openURL:url];
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
    }
    
}

//dissmiss keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtNum resignFirstResponder];
    [self.txtPass resignFirstResponder];
}

//maximum text field std number
- (void)limitTextField:(NSNotification *)note {
    int limit = 9;
    if ([self.txtNum.text length] > limit) {
        self.txtNum.text = [self.txtNum.text substringToIndex:limit];
    }
}


//round btn
-(void)viewDidAppear:(BOOL)animated{
    self.btnEnter.layer.cornerRadius = self.btnEnter.frame.size.height/4.0;
}



-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        NSLog(@"fdddddddd");
        [self makeAction];
    }
    return NO;
}

- (IBAction)btnTouchEnter:(id)sender {
    
    [self makeAction];
}

//============================
//goto marks
- (void)makeAction
{
    
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        if (self.txtNum.text && self.txtNum.text.length >= 8 && self.txtPass.text && self.txtPass.text.length > 0 && !hasAppeared)
        {
            // Update the UI on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:self.txtNum];
                [self performSegueWithIdentifier:@"gotoSegue1" sender:nil];
            });
            
            hasAppeared = YES;
        }else
        {
            // Update the UI on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMessage:@"تأكد من الخانات !"];
            });
            hasAppeared = NO;
        }
    };
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"تأكد من اتصالك بالانترنت !"];
        });
    };
    
    [internetReachableFoo startNotifier];
    
}
//============================

-(void) showMessage:(NSString *)message
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"حسناً"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"gotoSegue1"]) {
        
        ViewMarks *vc = (ViewMarks* )[[segue destinationViewController] topViewController ];
        if(self.txtNum.text.length == 8){
            
            NSMutableString *modif = [NSMutableString stringWithString:self.txtNum.text];
            [modif insertString:@"0" atIndex:1];
            NSLog(@"%@",modif);
            vc.stdNum = modif;
            
        }else{
            
            vc.stdNum = self.txtNum.text;
            
        }
        vc.stdPass = self.txtPass.text;
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    NSLog(@"unwind");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
