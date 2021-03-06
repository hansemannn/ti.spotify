/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSpotifyConnectButton.h"
#import "TiSpotifyConnectButtonProxy.h"
#import "TiUtils.h"

@implementation TiSpotifyConnectButtonProxy

-(void)viewDidAttach
{
    [(TiSpotifyConnectButton*)[self view] button];
}

#pragma mark Layout Helper

-(UIViewAutoresizing)verifyAutoresizing:(UIViewAutoresizing)suggestedResizing
{
    return suggestedResizing & ~(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth);
}

USE_VIEW_FOR_VERIFY_HEIGHT
USE_VIEW_FOR_VERIFY_WIDTH

-(TiDimension)defaultAutoWidthBehavior:(id)unused
{
    return TiDimensionAutoFill;
}

-(TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoFill;
}

@end
