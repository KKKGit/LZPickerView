//
//  LZPickerView.h
//  testJS
//
//  Created by Lvlinzhe on 2018/6/28.
//  Copyright © 2018年 wei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPickerView : UIView

- (instancetype)initWithItems:(NSArray *)items;

- (instancetype)initWithDatePickerMode:(UIDatePickerMode)pickerMode;

- (instancetype)initWithDateFormat:(NSString *)format  mode:(UIDatePickerMode)pickerMode;

- (void)showInView:(UIView *)view pickCompletion:(void (^)(NSString *string))completion;

@property (nonatomic ,strong)NSString *minimumDate;

@property (nonatomic ,strong)NSString *maximumDate;

NS_ASSUME_NONNULL_END

@end
