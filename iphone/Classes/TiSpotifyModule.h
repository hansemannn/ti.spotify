/**
 * ti.spotify
 *
 * Created by Hans Knoechel
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <SafariServices/SafariServices.h>

NSString* const kTiSpotifyNotification = @"TiSpotifyNotification";

@interface TiSpotifyModule : TiModule <SFSafariViewControllerDelegate>

- (void)initialize:(id)args;

- (NSNumber*)spotifyApplicationIsInstalled;

- (NSNumber*)supportsApplicationAuthentication;

- (NSNumber*)canHandleURL:(id)value;

@end
