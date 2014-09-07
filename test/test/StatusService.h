//
//  StatusService.h
//  test
//
//  Created by lzw on 14-9-7.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface StatusService : NSObject
+(NSArray *) findRecentStatuses:(NSInteger)limit;
@end
