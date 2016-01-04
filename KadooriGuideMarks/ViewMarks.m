//
//  ViewMarks.m
//  KadooriGuideMarks
//
//  Created by Moja on 1/3/16.
//  Copyright © 2016 MicroFuture. All rights reserved.
//

#import "ViewMarks.h"
#import "TFHpple.h"
#import "ViewController.h"
#import "CoursePlanObj.h"
#import "TableCell.h"

@interface ViewMarks ()
{
    NSMutableArray *myCourses;
    NSMutableArray *coursesHaveMarks;
}
@end

@implementation ViewMarks

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FLAnimatedImage *adsImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"output_uurJRI" ofType:@"GIF"]]];
    self.loaderImgg.animatedImage = adsImage;
    
    
    self.myBanner.adUnitID = @"ca-app-pub-7854422536442484/7108432252";
    self.myBanner.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"300f3df3e14fc1ceeced2d634f64c15a", nil];
    [self.myBanner loadRequest:request];
    
    self.myTable.hidden = YES;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        [self myTask];
    });
    
    
    self.myTable.delegate = self;
}



- (void)myTask {
    
    [NSThread sleepForTimeInterval:0.2];
    
    NSString* userAgent = @"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36";
    
    NSString *serverAddress = @"http://edugate.ptuk.edu.ps/edugate";
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response =
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&urlResponse error:&requestError];
    [NSThread sleepForTimeInterval:0.5];
    
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:response];
    NSString *parseQuery = @"//input[@id='javax.faces.ViewState']";
    NSArray* elements = [doc searchWithXPathQuery:parseQuery];
    
    if(elements.count <= 0){
        dispatch_async(dispatch_get_main_queue(), ^{
          [self showMessage:@"حدث خلل اثناء الاتصال،، اعد المحاولة او اعد فتح التطبيق،،"];
        });
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
        NSLog(@"Response code: %ld", (long)[httpResponse statusCode]);
        NSLog(@"emptyy 1");
        return;
    }
    NSString* javaxStr = [elements[0] objectForKey:@"value"];
    NSLog(@"444 == %@", javaxStr);
    
    [NSThread sleepForTimeInterval:0.1];
    //============ login ===============//
    serverAddress = @"http://edugate.ptuk.edu.ps/edugate/ui/common/home.faces";
    NSMutableURLRequest *request1 =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    NSString *post = [NSString stringWithFormat:@"loginFrm=loginFrm&loginFrm:username=%@&loginFrm:password=%@&loginFrm:loginI423mg=%@&javax.faces.ViewState=%@",self.stdNum, self.stdPass,@"%%D8%%AF%%D8%%AE%%D9%%88%%D9%%84", javaxStr];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    //getcokies from previous
    NSArray *cookies = [NSHTTPCookie
                        cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]
                        forURL:[NSURL URLWithString:@""]];
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request1 setAllHTTPHeaderFields:headers];
    
    //
    [request1 setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request1 setHTTPMethod: @"POST"];
    [request1 setHTTPShouldHandleCookies:YES];
    [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request1 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request1 setHTTPBody:postData];
    
    response =
    [NSURLConnection sendSynchronousRequest:request1
                          returningResponse:&urlResponse error:&requestError];
    
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    [NSThread sleepForTimeInterval:0.1];
    request1 =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:@"http://edugate.ptuk.edu.ps/edugate/ui/common/welcomeIndex.faces"]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    //getcokies from previous
    cookies = [NSHTTPCookie
               cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]
               forURL:[NSURL URLWithString:@""]];
    headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request setAllHTTPHeaderFields:headers];
    //
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setHTTPMethod: @"GET"];
    response =
    [NSURLConnection sendSynchronousRequest:request1
                          returningResponse:&urlResponse error:&requestError];
    
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    
    
    
    //==== check if correct
    doc       = [[TFHpple alloc] initWithHTMLData:response];
    parseQuery = @"//html";
    elements = [doc searchWithXPathQuery:parseQuery];
    
    if([elements count] <= 0){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        NSLog(@"elements count zero check stdNum stdPass");
        NSLog(@"emptyy 2");
        return;
    }
    
    if( ! [[elements[0] content] containsString:@"خروج"]){ //not correct
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"المعلومات التي ادخلتها خاطئة، اعد المحاولة مرة اخرى"];
        });
        
        return;
    }else{
        NSLog(@"aaaaaalll rightttttt !!!!");
    }
    [NSThread sleepForTimeInterval:0.1];
    //============== goto this semester courses =================
    serverAddress = @"http://edugate.ptuk.edu.ps/edugate/ui/student/studentSchedule/index/studentScheduleIndex.faces";
    request1 =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    //getcokies from previous
    cookies = [NSHTTPCookie
               cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]
               forURL:[NSURL URLWithString:@""]];
    headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request1 setAllHTTPHeaderFields:headers];
    //
    [request1 setHTTPMethod: @"GET"];
    response =
    [NSURLConnection sendSynchronousRequest:request1
                          returningResponse:&urlResponse error:&requestError];
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    
    [NSThread sleepForTimeInterval:0.1];
    //again to get this semester
    doc       = [[TFHpple alloc] initWithHTMLData:response];
    parseQuery = @"//input[@id='javax.faces.ViewState']";
    elements = [doc searchWithXPathQuery:parseQuery];
    
    if(elements.count <= 0){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        return;
    }
    javaxStr = [elements[0] objectForKey:@"value"];
    serverAddress = @"http://edugate.ptuk.edu.ps/edugate/ui/student/studentSchedule/index/studentScheduleIndex.faces";
    request1 =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    post = [NSString stringWithFormat:@"stdSchdl=stdSchdl&stdSchdl:semValue=20151&stdSchdl:getStdSdl=stdSchdl:getStdSdl&stdSchdl:j_id_id181=&javax.faces.ViewState=%@", javaxStr];
    postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    //getcokies from previous
    cookies = [NSHTTPCookie
               cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]
               forURL:[NSURL URLWithString:@""]];
    headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request1 setAllHTTPHeaderFields:headers];
    //
    [request1 setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request1 setHTTPMethod: @"POST"];
    [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request1 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request1 setHTTPBody:postData];
    
    
    response =
    [NSURLConnection sendSynchronousRequest:request1
                          returningResponse:&urlResponse error:&requestError];
    
    
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    
    doc   = [[TFHpple alloc] initWithHTMLData:response];
    parseQuery = @"//tbody//tr";
    elements = [doc searchWithXPathQuery:parseQuery];
    
    //--//---//
    myCourses = [[NSMutableArray alloc] init];
    //--//---//
    
    for (TFHppleElement* raw in elements) {//for each row
        
        //get num
        NSArray* ids = [raw searchWithXPathQuery:@"//td"];
        NSString* conn  = [[ids objectAtIndex:0] content];
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if ([conn rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
             NSLog(@"%@", conn);
            [myCourses addObject:conn];
        }
      
    }

    
    
    
    
    
    //==== get the plan where is the result
    
    serverAddress = @"http://edugate.ptuk.edu.ps/edugate/ui/student/plan/index/planIndex.faces";
    request1 =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    //getcokies from previous
    cookies = [NSHTTPCookie
               cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]
               forURL:[NSURL URLWithString:@""]];
    headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request1 setAllHTTPHeaderFields:headers];
    //
    [request1 setHTTPMethod: @"GET"];
    response =
    [NSURLConnection sendSynchronousRequest:request1
                          returningResponse:&urlResponse error:&requestError];
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    
    [NSThread sleepForTimeInterval:0.1];
    //again to get this semester
    doc       = [[TFHpple alloc] initWithHTMLData:response];
    parseQuery = @"//input[@id='javax.faces.ViewState']";
    elements = [doc searchWithXPathQuery:parseQuery];
    
    if(elements.count <= 0){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        return;
    }
    javaxStr = [elements[0] objectForKey:@"value"];
    serverAddress = @"http://edugate.ptuk.edu.ps/edugate/ui/student/plan/index/planIndex.faces";
    request1 =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:150
     ];
    post = [NSString stringWithFormat:@"stdPln=stdPln&stdPln:anlsCmd=stdPln:anlsCmd&javax.faces.ViewState=%@", javaxStr];
    postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    //getcokies from previous
    cookies = [NSHTTPCookie
               cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]
               forURL:[NSURL URLWithString:@""]];
    headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request1 setAllHTTPHeaderFields:headers];
    //
    [request1 setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request1 setHTTPMethod: @"POST"];
    [request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request1 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request1 setHTTPBody:postData];
    
    
    response =
    [NSURLConnection sendSynchronousRequest:request1
                          returningResponse:&urlResponse error:&requestError];
    
    
    //=error
    if (requestError){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessage:@"حدث خلل اثناء الاتصال.."];
        });
        
        NSLog(@"%@",[requestError localizedDescription]);
        NSLog(@"%@", [requestError userInfo]);
        return;
    }
    //==
    
    coursesHaveMarks = [[NSMutableArray alloc] init];
    
    NSLog(@"=====  coursesHaveMarks  ====");
    
    doc   = [[TFHpple alloc] initWithHTMLData:response];
    
    for(int i=0; i<=6; i++){
        
        parseQuery = [NSString stringWithFormat: @"//table[@id='plnCrs:majorPlan:%d:planCourses']//tbody//tr", i];
        NSArray *planRows = [doc searchWithXPathQuery:parseQuery];
        
        for(int j=0; j<planRows.count; j++){
            parseQuery = @"//div";
            NSArray *divs = [planRows[j] searchWithXPathQuery:parseQuery];
           
          
            
            for (int  r =0; r<myCourses.count; r++) {//forallcoursees
                NSString* ccc = (NSString *) myCourses[r];
                
                if([[divs[0] content] isEqualToString:ccc]){
                    
        
                    CoursePlanObj *coursePlan = [[CoursePlanObj alloc] init];
                    
                    coursePlan.cNum = [divs[0] content];
                    coursePlan.cName = [divs[1] content];
                    coursePlan.cGrade = [divs[4] content];
                    coursePlan.cColor = (NSString *)[divs[0] objectForKey:@"class"];
                    coursePlan.cSem = [divs[3] content];
                    coursePlan.cHours = [divs[2] content];
                    [coursesHaveMarks addObject:coursePlan];
                    
                    NSLog(@"eq %@", ccc);
                    break;
                }
            }
        }
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myTable.hidden = NO;
        self.loaderImgg.hidden = YES;
        [self.myTable reloadData];
    });
    
    
    //=====================
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 159;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [coursesHaveMarks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TableCell *cell;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    CoursePlanObj *curCourse = [coursesHaveMarks objectAtIndex:indexPath.row];
    
    cell.txtNum.text = curCourse.cNum;
    cell.txtName.text = curCourse.cName;
    cell.txtSem.text = [NSString stringWithFormat:@"%@ %@",@"الفصل:",curCourse.cSem];
    cell.txtHours.text = [NSString stringWithFormat:@"%@ %@",@"س:",curCourse.cHours];
    cell.txtGarde.text = [NSString stringWithFormat:@"%@ %@",@"الدرجة:",curCourse.cGrade];
    
    NSString *color = curCourse.cColor;
    
    if([color isEqualToString:@"plan_anls_0"]){
        cell.backgroundColor = [self colorWithHexString:@"66FC200C"];
        cell.txtNaje7.text = @"راسب";
    }else if([color isEqualToString:@"plan_anls_1"]){
        cell.backgroundColor = [self colorWithHexString:@"6625A508"];
        cell.txtNaje7.text = @"ناجح";
    }else if([color isEqualToString:@"plan_anls_2"]){
        cell.backgroundColor = [self colorWithHexString:@"AAF2E646"];
        cell.txtNaje7.text = @"معادة";
    }
    else if([color isEqualToString:@"plan_anls_3"]){
        cell.backgroundColor = [self colorWithHexString:@"66FCD8BD"];
        cell.txtNaje7.text = @"مسجلة";
    }
    else if([color isEqualToString:@"plan_anls_4"]){
        cell.backgroundColor = [self colorWithHexString:@"66ffffff"];
        cell.txtNaje7.text = @"غير مسجلة";
    }
    else if([color isEqualToString:@"plan_anls_5"]){
        cell.backgroundColor = [self colorWithHexString:@"66C9FFA3"];
        cell.txtNaje7.text = @"معفاة";
    }
    
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.layer.masksToBounds = true;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



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
                              [[NSURLCache sharedURLCache] removeAllCachedResponses];
                             [self performSegueWithIdentifier:@"backSegue" sender:nil];
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backSegue"]) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[segue sourceViewController]  dismissViewControllerAnimated:NO completion:NULL];
    }
}


- (IBAction)backkk:(id)sender {
    [self performSegueWithIdentifier:@"backSegue" sender:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 8) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *aString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 6;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
} 



@end
