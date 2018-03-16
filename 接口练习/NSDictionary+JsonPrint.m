//
//  NSDictionary+JsonPrint.m
//  接口练习
//
//  Created by OS X  on 18/3/12.
//
//

#import "NSDictionary+JsonPrint.h"

@implementation NSDictionary (JsonPrint)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:@"{\r\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    [mStr appendString:@"}"];
    return [mStr copy];
}
@end
