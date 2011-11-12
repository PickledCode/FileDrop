//
//  RSSocket.h
//
//  Created by Ryan Sullivan on 4/10/11.
//  Copyright 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h> 
#include <stdlib.h>
#include <unistd.h>

@class RSSocket;
@protocol RSSocketDelegate <NSObject>
-(void)socketDidDisconnect:(RSSocket*)sock;
@end

@interface RSSocket : NSObject {
    int sockfd;
    BOOL isOpen;
	BOOL isLocal;
    NSString *host;
    
    id<RSSocketDelegate> delegate;
    NSThread *delegateThread;
    
    NSRecursiveLock *readLock;
    NSRecursiveLock *writeLock;
}

-(id)initWithHost:(NSString*)remHost port:(int)port;
-(id)initWithSockfd:(int)fd;

-(void)setLocal:(BOOL)loc;
-(void)setHost:(NSString*)h;
-(void)setDelegate:(id)d;

-(BOOL)isLocal;
-(NSString*)host;
-(int)fd;
-(BOOL)isOpen;

-(void)close;

-(NSData*)readData:(int)len;
-(BOOL)writeData:(NSData*)d;

@end
