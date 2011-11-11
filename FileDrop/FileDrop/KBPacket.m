//
//  KBPacket.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "KBPacket.h"

@implementation KBPacket

+(NSData*)dataWithObject:(NSObject*)object {
    return kb_encode_full(object);
}

+(void)writeObject:(NSObject*)object toSocket:(RSSocket*)socket {
    //[socket writeData:[self dataWithObject:object]];
    kb_encode_full_fd(object, [socket fd]);
}

// Helpers
+(void)writeAuth:(NSString*)token toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"auth" forKey:@"type"];
    [dict setObject:[token dataUsingEncoding:NSUTF8StringEncoding] forKey:@"token"];
    [self writeObject:dict toSocket:socket];
}

@end
