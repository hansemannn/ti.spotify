/**
 * ti.spotify
 *
 * Created by Hans Knoechel
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <Spotify/Spotify.h>

@interface TiSpotifyModule : TiModule

- (void)initialize:(id)args;

- (NSNumber*)spotifyApplicationIsInstalled;

- (NSNumber*)supportsApplicationAuthentication;

- (NSNumber*)canHandleURL:(id)value;

@end
