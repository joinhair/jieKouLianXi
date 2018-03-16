//
//  NSArray+JsonPrint.m
//  接口练习
//
//  Created by OS X  on 18/3/12.
//
//

#import "NSArray+JsonPrint.h"

@implementation NSArray (JsonPrint)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:@"(\r\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    [mStr appendString:@")"];
    return [mStr copy];
}
@end
