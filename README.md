#Share

一个用 AVOS Cloud 事件流系统 API 做的 iOS App，功能类似微博,twitter。还正在开发中。

[iOS事件流指南](https://cn.avoscloud.com/docs/status_system.html#ios-sdk中的使用方法)
[AVOS Cloud 站点下载地址](https://download.avoscloud.com/demo/)

根据这篇指南提供的 API 只用了少量的代码便完成了下列的功能，

=====

## 当前的功能
* 用户登录注册注销
* 发布粉丝能看到的状态
* 看到关注者发出的状态
* 关注或取消关注其它人


iOS App , use to share friends status like facebook, twitter.

![img](https://github.com/lzwjava/plan/blob/master/share1.png)

除界面外，核心逻辑只用了大约100行代码：
```objective-c
#import "StatusService.h"

@implementation StatusService

+(NSArray *)findRecentStatuses:(NSInteger)limit{
    AVStatusQuery *query=[AVStatus inboxQuery:kAVStatusTypeTimeline];
    [query includeKey:@"source"];
    //query.limit=50;
    NSArray *objects=[query findObjects];
    return objects;
}

+(NSArray *)findAllUsers:(NSString* )subName{
    AVQuery *q=[AVUser query];
    if(subName){
        [q whereKey:@"username" containsString:subName];
    }
    return [q findObjects];
}

+(NSArray*)findAllUsersExceptMe:(NSString*) subName{
    NSArray *users=[self findAllUsers:subName];
    NSMutableArray *_users=[NSMutableArray arrayWithArray:users];
    AVUser* currentUser=[AVUser currentUser];
    for(AVUser *_user in _users){
        if([[currentUser username] isEqualToString:[_user username]]){
            [_users removeObject:_user];
            break;
        }
    }
    return [NSArray arrayWithArray:_users];
}

+(BOOL)askFollowStatus:(AVUser *)user askFollower:(BOOL) askFollower{
    AVUser* curUser=[AVUser currentUser];
    AVQuery *q;
    if(askFollower){
        q=[AVUser followerQuery:curUser.objectId];
        [q whereKey:@"follower" equalTo:user];
    }else{
        q=[AVUser followeeQuery:curUser.objectId];
        [q whereKey:@"followee" equalTo:user];
    }
    AVObject* follow=[q getFirstObject];
    if(follow){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL) isMyFollower:(AVUser *)user{
    return [self askFollowStatus:user askFollower:YES];
}

+(BOOL) isMyFollowee:(AVUser *)user{
    return [self askFollowStatus:user askFollower:NO];
}

+(NSString *)followStatus:(AVUser *)user{
    BOOL isMyFollower=[self isMyFollower:user];
    NSLog(@"isMyFollower");
    BOOL isMyFollowee=[self isMyFollowee:user];
    if(isMyFollower && isMyFollowee){
        return @"互相关注";
    }else if(isMyFollower){
        return @"Ta关注了您";
    }else if(isMyFollowee){
        return @"已关注";
    }else{
        return @"";
    }
}

+(NSString *)followOperationTitle:(BOOL)followed{
    if(followed){
        return @"取消关注";
    }else{
        return @"关注Ta";
    }
}

+(void)followOperation:(BOOL)followed user:(AVUser*) user{
    AVUser* curUser=[AVUser currentUser];
    if(followed){
        [curUser unfollow:user.objectId andCallback:^(BOOL succeeded, NSError *error) {
        }];
    }else{
        [curUser follow:user.objectId andCallback:^(BOOL succeeded, NSError *error) {
        }];
    }
}

+(void)sendStatus:(NSString*)text andCallBack:(AVBooleanResultBlock)callBack{
    AVStatus *status=[[AVStatus alloc] init];
    AVUser* curUser=[AVUser currentUser];
    NSLog(@"curUser=%@",[curUser username]);
    status.source=curUser;
    status.data=@{@"text":text};
    [AVStatus sendStatusToFollowers:status andCallback:callBack];
}
@end
```

