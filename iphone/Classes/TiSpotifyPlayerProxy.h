/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>

@interface TiSpotifyPlayerProxy : TiProxy {
    SPTAudioStreamingController *_player;
}

@end
