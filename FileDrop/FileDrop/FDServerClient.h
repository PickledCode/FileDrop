//
//  FDServerClient.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSocket.h"
#import "FDDefines.h"
#import "KBPacket.h"

@class FDFileManager;

@interface FDServerClient : NSObject {
    RSSocket *socket;
    NSString *token;
}

-(id)initWithToken:(NSString*)token;

@end
