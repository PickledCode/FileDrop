//
//  KBPacket.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "KBPacket.h"
#import "FDFileRecv.h"
#import "FDFileSend.h"

@implementation KBPacket

+(NSData*)dataWithObject:(NSObject*)object {
    return kb_encode_full(object);
}

+(BOOL)writeObject:(NSObject*)object toSocket:(RSSocket*)socket {
    //return [socket writeData:[self dataWithObject:object]];
    return kb_encode_full_fd(object, [socket fd]);
}

// Helpers
+(BOOL)writeAuth:(NSString*)token toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"auth" forKey:@"type"];
    [dict setObject:[token dataUsingEncoding:NSUTF8StringEncoding] forKey:@"token"];
    return [self writeObject:dict toSocket:socket];
}

+(BOOL)writeDataDict:(NSDictionary*)data toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"data" forKey:@"type"];
    [dict setObject:data forKey:@"data"];
    return [self writeObject:dict toSocket:socket];
}

+(BOOL)writeCancelFile:(FDFile*)file toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"file" forKey:@"type"];
    [dict setObject:@"cancel" forKey:@"action"];
    [dict setObject:[file fileID] forKey:@"id"];
    return [self writeDataDict:dict toSocket:socket];
}

+(BOOL)writeFileBytes:(FDFile*)file toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"file" forKey:@"type"];
    [dict setObject:@"update" forKey:@"action"];
    [dict setObject:[file fileID] forKey:@"id"];
    [dict setObject:[NSNumber numberWithUnsignedInteger:[file bytesTransfered]] forKey:@"bytesTransfered"];
    return [self writeDataDict:dict toSocket:socket];
}
+(BOOL)writeAcceptFile:(FDFile*)file toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"file" forKey:@"type"];
    [dict setObject:@"accept" forKey:@"action"];
    [dict setObject:[file fileID] forKey:@"id"];
    return [self writeDataDict:dict toSocket:socket];
}
+(BOOL)writeDeclineFile:(FDFile*)file toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"file" forKey:@"type"];
    [dict setObject:@"decline" forKey:@"action"];
    [dict setObject:[file fileID] forKey:@"id"];
    return [self writeDataDict:dict toSocket:socket];
}

+(BOOL)writeInitFile:(FDFileSend*)file toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"file" forKey:@"type"];
    [dict setObject:@"init" forKey:@"action"];
    [dict setObject:[file fileID] forKey:@"id"];
    [dict setObject:[file genMeta] forKey:@"meta"];
    return [self writeDataDict:dict toSocket:socket];
}
+(BOOL)writeData:(NSData*)data forFile:(FDFile*)file toSocket:(RSSocket*)socket {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"file" forKey:@"type"];
    [dict setObject:@"data" forKey:@"action"];
    [dict setObject:[file fileID] forKey:@"id"];
    [dict setObject:data forKey:@"data"];
    NSLog(@"-writeData %lu for File: %@", [data length], file);
    return [self writeDataDict:dict toSocket:socket];
}
@end
