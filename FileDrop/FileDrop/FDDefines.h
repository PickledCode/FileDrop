//
//  FDDefines.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/10/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#ifndef FileDrop_FDDefines_h
#define FileDrop_FDDefines_h


#define FDFM_FILERECV_SECTION 0
#define FDFM_FILESEND_SECTION 1


#define FD_SERVER_HOST @"127.0.0.1"
#define FD_SERVER_PORT 9000

#define FD_UPLOAD_BUFFER (1024*5)

#define FD_PACKET_TYPE_INIT @"init"
#define FD_PACKET_TYPE_CANC @"cancel"
#define FD_PACKET_TYPE_ACPT @"accept"
#define FD_PACKET_TYPE_DATA @"data"


#endif
