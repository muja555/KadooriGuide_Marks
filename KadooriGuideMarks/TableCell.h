//
//  TableCell.h
//  KadooriGuideMarks
//
//  Created by Moja on 1/4/16.
//  Copyright © 2016 MicroFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *txtName;
@property (strong, nonatomic) IBOutlet UILabel *txtNum;

@property (strong, nonatomic) IBOutlet UILabel *txtHours;
@property (strong, nonatomic) IBOutlet UILabel *txtSem;
@property (strong, nonatomic) IBOutlet UILabel *txtGarde;
@property (strong, nonatomic) IBOutlet UILabel *txtNaje7;

@end
