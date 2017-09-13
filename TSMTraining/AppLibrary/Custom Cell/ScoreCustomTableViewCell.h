//
//  ScoreCustomTableViewCell.h
//  TSMTraining
//
//  Created by Praveen Sharma on 13/09/17.
//
//

#import <UIKit/UIKit.h>

@interface ScoreCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CRMNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *CRMIdLbl;
@property (weak, nonatomic) IBOutlet UITextField *postCoreTxt;
@property (weak, nonatomic) IBOutlet UITextField *preScoreTxt;

@end
