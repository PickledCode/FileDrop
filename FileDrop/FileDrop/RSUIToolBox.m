//
//  RSUIToolBox.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "RSUIToolBox.h"

@implementation RSUIToolBox

+(NSFont*)fontOfSize:(CGFloat)fontSize {
    return [NSFont fontWithName:@"HelveticaNeue" size:fontSize];
}
+(NSFont*)boldFontOfSize:(CGFloat)fontSize {
    return [NSFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

@end
