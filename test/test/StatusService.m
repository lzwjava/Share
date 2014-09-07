//
//  StatusService.m
//  test
//
//  Created by lzw on 14-9-7.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import "StatusService.h"

@implementation StatusService

+(NSArray *)findRecentStatuses:(NSInteger)limit{
    AVStatusQuery *query=[AVStatus inboxQuery:kAVStatusTypeTimeline];
    query.limit=50;
    NSArray *objects=[query findObjects];
    return objects;
}

@end
