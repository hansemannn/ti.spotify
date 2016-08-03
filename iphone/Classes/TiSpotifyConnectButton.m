/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSpotifyConnectButton.h"

@implementation TiSpotifyConnectButton

- (void)dealloc
{
    RELEASE_TO_NIL(button);
    [super dealloc];
}

- (SPTConnectButton*)button
{
    if (!button) {
        button = [[SPTConnectButton alloc] initWithFrame:[self bounds]];
        [self addSubview:button];
    }
    
    return button;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    for (UIView *subview in [self subviews]) {
        [subview setFrame:frame];
    }
    
    [super frameSizeChanged:frame bounds:bounds];
}

-(BOOL)hasTouchableListener
{
    return YES;
}

-(CGFloat)verifyWidth:(CGFloat)suggestedWidth
{
    return [self sizeThatFits:CGSizeZero].width;
}

-(CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
    return [self sizeThatFits:CGSizeZero].height;
}

@end
