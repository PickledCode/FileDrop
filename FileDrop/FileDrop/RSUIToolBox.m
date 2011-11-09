//
//  RSUIToolBox.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "RSUIToolBox.h"

@implementation RSUIToolBox

+(TUIFont*)fontOfSize:(CGFloat)fontSize {
    return [TUIFont fontWithName:@"HelveticaNeue" size:fontSize];
}
+(TUIFont*)boldFontOfSize:(CGFloat)fontSize {
    return [TUIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

@end
