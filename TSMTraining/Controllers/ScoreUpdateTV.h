//
//  ScoreUpdateTV.h
//  TSMTraining
//
//  Created by Praveen Sharma on 18/09/17.
//
//

#import "TSMViewController.h"

@interface ScoreUpdateTV : TSMViewController

@property(nonatomic, strong) ScoreData *scoreData;
@property(nonatomic, strong) void (^onCompletion)(ScoreData *scoreUpdare);


@end
