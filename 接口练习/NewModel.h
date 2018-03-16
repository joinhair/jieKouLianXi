//
//  NewModel.h
//  接口练习
//
//  Created by OS X  on 18/3/16.
//
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject

@property (nonatomic, copy) NSString *text;

+ (instancetype)newModelWithDict:(NSDictionary *)dict;
@end
