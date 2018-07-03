# LZPickerViewDemo

A simple picker like WeChat.

<img width="190" height="409" src="https://raw.githubusercontent.com/KKKGit/LZPickerViewDemo/master/GIFs/preview.gif">

#Installation

LZPickerView is available on CocoaPods. Just add the following to your project Podfile:
```
platform :ios, '8.0'
pod 'LZPickerView', '~> 0.1.2'
```

#Usage

##Import:
```
#import "LZPickerView.h"
```
##Create picker and show:
```
LZPickerView *pickerView = [[LZPickerView alloc] initWithItems:@[@"item_1",@"item_2",@"item_3"]];
[pickerView showInView:self.view pickCompletion:^(NSString * _Nonnull string) {
    
}];
```
##Or
```
LZPickerView *pickerView = [[LZPickerView alloc] initWithDatePickerMode:UIDatePickerModeDateAndTime];
[pickerView showInView:self.view pickCompletion:^(NSString * _Nonnull string) {
    
}];
```
