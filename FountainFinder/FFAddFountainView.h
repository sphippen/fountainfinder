//
//  FFAddFountainView.h
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFAddFountainView : UIView

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) int temperature;
@property (nonatomic, readonly) int pressure;
@property (nonatomic, readonly) int cleanliness;
@property (readonly) UIButton* makeFountain;

@end
