//
//  KBPacket.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBEncodeObjC.h"
#import "RSSocket.h"

@interface KBPacket : NSObject

+(NSData*)dataWithObject:(NSObject*)object;
+(void)writeObject:(NSObject*)object toSocket:(RSSocket*)socket;
+(void)writeAuth:(NSString*)token toSocket:(RSSocket*)socket;

@end
