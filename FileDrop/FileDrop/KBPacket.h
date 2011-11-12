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
+(BOOL)writeObject:(NSObject*)object toSocket:(RSSocket*)socket;

+(BOOL)writeAuth:(NSString*)token toSocket:(RSSocket*)socket;
// Any file req
+(BOOL)writeCancelFile:(FDFile*)file toSocket:(RSSocket*)socket;
// Recv file reqs
+(BOOL)writeFileBytes:(FDFile*)file toSocket:(RSSocket*)socket;
+(BOOL)writeAcceptFile:(FDFile*)file toSocket:(RSSocket*)socket;
+(BOOL)writeDeclineFile:(FDFile*)file toSocket:(RSSocket*)socket;
// Send file reqs
+(BOOL)writeInitFile:(FDFileSend*)file toSocket:(RSSocket*)socket;
+(BOOL)writeData:(NSData*)data forFile:(FDFile*)file toSocket:(RSSocket*)socket;

@end
