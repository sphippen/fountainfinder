//
//  FFAddFountainViewController.h
//  FountainFinder
//
//  Created by Spencer Phippen on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFFountain.h"

typedef void (^FFAddFountainResult)(FFFountain* fountain);

@interface FFAddFountainViewController : UIViewController

@property (copy) FFAddFountainResult completion;

@end
