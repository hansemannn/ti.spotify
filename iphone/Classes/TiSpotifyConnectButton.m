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
        button = [[[SPTConnectButton alloc] init] retain];
        [self setFrame:[button frame]];
        [self addSubview:button];
    }
    
    return button;
}


- (IBAction)didTouchUpInside:(id)sender
{
    if ([[self proxy] _hasListeners:@"click"]) {
        [[self proxy] fireEvent:@"click" withObject:nil];
    }
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
