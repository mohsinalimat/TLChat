//
//  TLMessageManager+MessageRecord.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageManager+MessageRecord.h"

@implementation TLMessageManager (MessageRecord)

- (void)messageRecordForPartner:(NSString *)partnerID
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete
{
    [self.messageStore messagesByUserID:self.userID partnerID:partnerID fromDate:date count:count complete:^(NSArray *data, BOOL hasMore) {
        complete(data, hasMore);
    }];
}

- (void)chatFilesForPartnerID:(NSString *)partnerID
                    completed:(void (^)(NSArray *))completed
{
    NSArray *data = [self.messageStore chatFilesByUserID:self.userID partnerID:partnerID];
    completed(data);
}

- (BOOL)deleteMessageByMsgID:(NSString *)msgID
{
    return [self.messageStore deleteMessageByMessageID:msgID];
}

- (BOOL)deleteMessagesByPartnerID:(NSString *)partnerID
{
    return [self.messageStore deleteMessagesByUserID:self.userID partnerID:partnerID];
}

- (BOOL)deleteAllMessages
{
    BOOL ok = [self.messageStore deleteMessagesByUserID:self.userID];
    if (ok) {
        ok = [self.conversationStore deleteConversationsByUid:self.userID];
    }
    return ok;
}


@end
