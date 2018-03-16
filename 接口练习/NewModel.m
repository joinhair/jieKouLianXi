//
//  NewModel.m
//  接口练习
//
//  Created by OS X  on 18/3/16.
//
//

#import "NewModel.h"

@implementation NewModel

+ (instancetype)newModelWithDict:(NSDictionary *)dict{
    NewModel *newModel = [[NewModel alloc] init];
    [newModel setValuesForKeysWithDictionary:dict];
    return newModel;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
