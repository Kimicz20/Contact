//
//  Contact.m
//  Contact
//
//  Created by Geek on 16/6/1.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "Contact.h"

@implementation Contact

//将对象归档时候调用,写清 需要存储的属性以及如何存储
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_telNum forKey:@"telNum"];
}

-(instancetype)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        _name = [decoder decodeObjectForKey:@"name"];
        _telNum = [decoder decodeObjectForKey:@"telNum"];
    }
    return self;
}
@end
