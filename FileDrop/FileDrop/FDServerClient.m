//
//  FDServerClient.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDServerClient.h"
#import "FDFileManager.h"

@implementation FDServerClient

@synthesize socket;

-(id)initWithToken:(NSString*)tok andFileManager:(FDFileManager *)fm {
    self = [super init];
    if (self) {
        fileManager = fm;
        isConnected = NO;
        
        socket = [[RSSocket alloc] initWithHost:FD_SERVER_HOST port:FD_SERVER_PORT];
        if (!socket) {
            return nil;
        }
        
        readThread = [[NSThread alloc] initWithTarget:self selector:@selector(readSocket:) object:nil];
        [readThread start];
        
        token = [tok copy];
        [KBPacket writeAuth:token toSocket:socket];
        
        uploadThread = [[NSThread alloc] initWithTarget:self selector:@selector(uploadSocket:) object:nil];
    }
    return self;
}

-(void)dealloc {
    [uploadThread cancel];
    [readThread cancel];
    [socket close];
}


#pragma mark -
#pragma mark Socket IO

-(void)readSocket:(id)sender {
    @autoreleasepool {
        if ([NSThread currentThread] != readThread) {
            NSLog(@"-readSocket called from incorrect thread");
            return;
        }
        
        while(![readThread isCancelled]) {
            
            NSLog(@"Starting read...");
            id obj = kb_decode_full_fd([socket fd]);
            if (![obj isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            NSDictionary *dict = (NSDictionary*)obj;
            NSString *dType = [dict objectForKey:@"type"];
            
            NSLog(@"Got dict: %@", dict);
            
            if ([dType isEqualToString:@"conn"]) {
                // Action and possible start info
                NSString *dAction = [dict objectForKey:@"action"];
                
                if ([dAction isEqualToString:@"connected"]) {
                    isConnected = YES;
                } else if ([dAction isEqualToString:@"disconnected"]) {
                    [uploadThread cancel];
                    isConnected = NO;
                }
                
            } else if ([dType isEqualToString:@"error"]) {
                // Message and error code
                NSString *dMsg = [dict objectForKey:@"msg"];
                NSNumber *dCode = [dict objectForKey:@"code"];
                
                NSLog(@"KBProxyServer ERROR: %d: %@", [dCode intValue], dMsg);
                if ([dCode intValue] == 1) {
                    [fileManager.delegate fileManagerErrorTokenInvalid:fileManager];
                }
                
            } else if ([dType isEqualToString:@"data"]) {
                // [uploadThread start];
            }
            
        }
    }
}

-(void)uploadSocket:(id)sender {    
    @autoreleasepool {
        if ([NSThread currentThread] != uploadThread) {
            NSLog(@"-uploadSocket called from incorrect thread");
            return;
        } else if (!isConnected) {
            NSLog(@"Not connected, but in upload thread. Uh oh.");
        }
        
        while (![uploadThread isCancelled]) {
            if (!isConnected) {
                [NSThread sleepForTimeInterval:0.25];
                continue;
            }
            
            NSArray *files = [fileManager activeFilesInSection:FDFM_FILESEND_SECTION];
            NSUInteger uploadBuffer = FD_UPLOAD_BUFFER;
            
            if ([files count] < 1) {
                [NSThread sleepForTimeInterval:0.2];
            } else if ([files count] == 1) {
                uploadBuffer *= 2;
            }
            
            for (FDFile *file in files) {
                NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:file.localPath];
                [handle seekToFileOffset:file.bytesTransfered];
                
                NSData *data = [handle readDataOfLength:uploadBuffer];
                [KBPacket writeData:data forFile:file toSocket:socket];
                
                file.bytesTransfered = file.bytesTransfered + uploadBuffer;
            }
        }
    }
}

@end
