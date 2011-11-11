//
//  FDServerClient.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDServerClient.h"

@implementation FDServerClient

-(id)initWithToken:(NSString*)tok {
    self = [super init];
    if (self) {
        socket = [[RSSocket alloc] initWithHost:FD_SERVER_HOST port:FD_SERVER_PORT];
        if (!socket) {
            [super dealloc];
            return nil;
        }
        
        token = [tok copy];
        [KBPacket writeAuth:token toSocket:socket];
    }
    return self;
}

-(void)dealloc {
    [token release];
    [socket release];
    [super dealloc];
}

@end
