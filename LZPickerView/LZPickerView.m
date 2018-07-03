//
//  LZPickerView.m
//  testJS
//
//  Created by Lvlinzhe on 2018/6/28.
//  Copyright © 2018年 wei wang. All rights reserved.
//

#import "LZPickerView.h"

#define l_BaseViewHeight (300 + l_SareaBottom)
#define l_SareaBottom (l_is_iPhone_X ? 34 : 0)
#define l_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define l_is_iPhone_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

typedef NS_ENUM(NSUInteger, LZPickerViewType) {
    LZPickerViewDefault = 0,
    LZPickerViewDate = 1
};

@interface LZPickerView()

@property (strong, nonatomic) NSArray *pickerItems;
@property (copy, nonatomic) NSString *dateFormat;
@property (assign, nonatomic) LZPickerViewType pickerType;

@property (assign, nonatomic) BOOL showCompleted;

@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *baseView;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) UIView *superView;
@property (nonatomic, copy) void(^handler)(NSString * result);

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottom;

@end

@implementation LZPickerView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items{
    self = [self init];
    if (self) {
        self.pickerType = LZPickerViewDefault;
        self.pickerItems = items;
        self.datePickerView.hidden = YES;
    }
    return self;
}

- (instancetype)initWithDatePickerMode:(UIDatePickerMode)pickerMode{
    return [self initWithDateFormat:@"YYYY-MM-dd HH-mm-ss" mode:pickerMode];
}

- (instancetype)initWithDateFormat:(NSString *)format  mode:(UIDatePickerMode)pickerMode{
    self = [self init];
    if (self) {
        self.pickerType = LZPickerViewDate;
        self.dateFormat = format;
        self.datePicker.datePickerMode = pickerMode;
        self.pickerView.hidden = YES;
    }
    return self;
}

- (void)showInView:(UIView *)view pickCompletion:(void (^)(NSString *string))completion{
    self.superView = view;
    self.handler = completion;
    [self addToSuperView];
    [self show];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    if (l_is_iPhone_X) {
        self.baseHeight.constant = l_BaseViewHeight;
        self.cancelHeight.constant = self.cancelHeight.constant + l_SareaBottom;
        self.cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    }
    [self.confirmButton setBackgroundImage:[self creatImageWithColor:l_RGBA(255, 255, 255, 0.85)] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[self creatImageWithColor:l_RGBA(245, 245, 245, 0.80)] forState:UIControlStateHighlighted];
    [self.cancelButton setBackgroundImage:[self creatImageWithColor:l_RGBA(255, 255, 255, 0.85)] forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:[self creatImageWithColor:l_RGBA(245, 245, 245, 0.80)] forState:UIControlStateHighlighted];
}

- (void)addToSuperView{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.superView addSubview:self];
    [self.superView addConstraints:@[[NSLayoutConstraint constraintWithItem:self.superView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1
                                                                   constant:0],
                                     [NSLayoutConstraint constraintWithItem:self.superView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:0],
                                     [NSLayoutConstraint constraintWithItem:self.superView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1
                                                                   constant:0],
                                     [NSLayoutConstraint constraintWithItem:self.superView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:0]
                                     ]];
    [self layoutIfNeeded];
}

- (void)show{
    
    self.showCompleted = NO;
    self.viewBottom.constant = l_BaseViewHeight;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.blackView.alpha = 0.5f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.showCompleted = YES;
    }];
}

- (void)hide{
    
    if (!self.showCompleted) return;
    self.viewBottom.constant = 0;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.blackView.alpha = 0.0f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

- (IBAction)confirmButtonClick:(UIButton *)sender {
    if (self.pickerType == LZPickerViewDate){
        if (self.handler) {
            self.handler([self dateToStringWithFormat:self.dateFormat date:self.datePicker.date]);
        }
    }else{
        if (self.handler) {
            self.handler([self.pickerItems objectAtIndex:[self.pickerView selectedRowInComponent:0]]);
        }
    }
    [self hide];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self hide];
}

- (void)setMinimumDate:(NSString *)minimumDate{
    self.datePicker.minimumDate = [self dateFromStringWithFormat:@"yyyy-MM-dd HH:mm" string:minimumDate];
}

- (void)setMaximumDate:(NSString *)maximumDate{
    self.datePicker.maximumDate = [self dateFromStringWithFormat:@"yyyy-MM-dd HH:mm" string:maximumDate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.pickerItems count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerItems objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:20.0f];
        //        pickerLabel.adjustsFontSizeToFitWidth = YES;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSDate *)dateFromStringWithFormat:(NSString *)format string:(NSString *)string{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: format];
    NSDate *destDate= [formatter dateFromString:string];
    return destDate;
}

- (NSString *)dateToStringWithFormat:(NSString *)format date:(NSDate *)date{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

- (UIImage *)creatImageWithColor:(UIColor *)color{
    
    CGRect rect = (CGRect){{0.0f,0.0f},CGSizeMake(5, 5)};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
