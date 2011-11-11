//
//  RSSocket.m
//
//  Created by Ryan Sullivan on 4/10/11.
//  Copyright 2011 Freelance Web Developer. All rights reserved.
//

#import "RSSocket.h"

//#define kMaxBufferSize 65535
//#define kMaxBufferSize 16384
#define kMaxBufferSize 0x4000

@interface RSSocket (Private)
-(void)closed;
@end



@implementation RSSocket

-(id)initWithHost:(NSString*)remHost port:(int)port {
	int mySockfd;
	
	struct sockaddr_in serv_addr;
	struct hostent *server;
	mySockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (mySockfd < 0) {
		NSLog(@"Socket error?");
		return nil;
	}
	server = gethostbyname([remHost UTF8String]);
	
	bzero((char *)&serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	bcopy((char *)server->h_addr, 
		  (char *)&serv_addr.sin_addr.s_addr,
		  server->h_length);
	serv_addr.sin_port = htons(port);
	
	if (connect(mySockfd, (const struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
		NSLog(@"Socket no connect?");
		return nil;
	}
	
	
	self = [self initWithSockfd:mySockfd];
	if (self) {
		[self setHost:remHost];
	}
	return self;
}
-(id)initWithSockfd:(int)fd {
    self = [super init];
    if (self) {
        sockfd = fd;
        isOpen = YES;
    }
    return self;
}

-(void)dealloc {
	[self close];
}


-(void)setLocal:(BOOL)loc {
	isLocal = loc;
}
-(void)setHost:(NSString*)h {
    host = h;
}
-(void)setDelegate:(id)d {
    delegate = d;
    delegateThread = [NSThread currentThread];
}

-(BOOL)isLocal { return isLocal; }
-(NSString*)host { return host; }
-(int)fd { return sockfd; }
-(BOOL)isOpen { return isOpen; }

-(void)close {
    if ([self isOpen]) {
        close(sockfd);
    }
    [self closed];
}
-(void)closed {
    if ([self isOpen]) {
        isOpen = NO;
        if ([(id)delegate respondsToSelector:@selector(socketDidDisconnect:)]) {
            [(id)delegate performSelector:@selector(socketDidDisconnect:) onThread:delegateThread withObject:self waitUntilDone:NO];
        }
    }
}

-(NSData*)readData:(int)len {
    if (![self isOpen]) { return nil; }
    int count = 0;
    char *bytes = (char*)malloc(len);
    while (count < len) {
        int needs = len - count;
        if (needs > kMaxBufferSize) { needs = kMaxBufferSize; }
        ssize_t add = recv(sockfd, &bytes[count], needs, 0);
        if (add <= 0) {
            [self close];
            free(bytes);
            return nil;
        }
        count += add;
    }
    return [NSData dataWithBytesNoCopy:bytes length:count freeWhenDone:YES];
}
-(BOOL)writeData:(NSData*)d {
    if (![self isOpen]) { return NO; }
    int written = 0;
    const char *bytes = [d bytes];
    while (written < [d length]) {
        int needsToWrite = (int)[d length] - written;
        if (needsToWrite > kMaxBufferSize) { needsToWrite = kMaxBufferSize; }
        ssize_t add = send(sockfd, &bytes[written], needsToWrite, 0);
        if (add < 0) {
            [self close];
            return NO;
        }
        written += add;
    }
    return YES;
}

@end
