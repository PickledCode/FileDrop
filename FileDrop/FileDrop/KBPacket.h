//
//  KBPacket.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBEncodeObjC.h"
#import "KBDecodeObjC.h"
#import "RSSocket.h"
#import "FDFile.h"

@class FDFileSend, FDFileRecv;


@interface KBPacket : NSObject

+(NSData*)dataWithObject:(NSObject*)object;
+(void)writeObject:(NSObject*)object toSocket:(RSSocket*)socket;

+(void)writeAuth:(NSString*)token toSocket:(RSSocket*)socket;
// Recv file reqs
+(void)writeFileBytes:(FDFile*)file toSocket:(RSSocket*)socket;
+(void)writeAcceptFile:(FDFile*)file toSocket:(RSSocket*)socket;
+(void)writeDeclineFile:(FDFile*)file toSocket:(RSSocket*)socket;
// Send file reqs
+(void)writeInitFile:(FDFileSend*)file toSocket:(RSSocket*)socket;
+(void)writeData:(NSData*)data forFile:(FDFile*)file toSocket:(RSSocket*)socket;

@end
