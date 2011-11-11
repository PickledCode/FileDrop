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
    __weak FDFileManager *fileManager;
    
    RSSocket *socket;
    NSThread *readThread;
    NSThread *uploadThread;
    
    NSString *token;
}

-(id)initWithToken:(NSString*)token andFileManager:(FDFileManager*)fm;

@end
