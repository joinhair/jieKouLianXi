//
//  ViewController.h
//  接口练习
//
//  Created by OS X  on 18/3/10.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;

- (void)getRequest;
- (void)postRequest;

- (void)syncGet;
- (void)syncPost;

- (void)aSyncGet;
- (void)aSyncPost;
@end

