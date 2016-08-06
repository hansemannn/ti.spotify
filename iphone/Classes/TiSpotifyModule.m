/**
 * ti.spotify
 *
 * Created by Hans Knoechel
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiSpotifyModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSpotifyModule

#pragma mark Internal

- (id)moduleGUID
{
	return @"374c1666-e935-4867-ad06-388c2ed57953";
}

- (NSString*)moduleId
{
	return @"ti.spotify";
}

#pragma Public APIs

- (void)initialize:(id)args
{
    NSArray *scopes;
    NSString *clientId;
    NSString *callbackURL;
    
    ENSURE_ARG_FOR_KEY(scopes, args, @"scopes", NSArray);
    ENSURE_ARG_FOR_KEY(clientId, args, @"clientId", NSString);
    ENSURE_ARG_FOR_KEY(callbackURL, args, @"callbackURL", NSString);
    
    [[SPTAuth defaultInstance] setClientID:clientId];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:callbackURL]];
    [[SPTAuth defaultInstance] setRequestedScopes:scopes];
}

- (NSNumber*)spotifyApplicationIsInstalled
{
    return NUMBOOL([SPTAuth spotifyApplicationIsInstalled]);
}

- (NSNumber*)supportsApplicationAuthentication
{
    return NUMBOOL([SPTAuth supportsApplicationAuthentication]);
}

- (NSNumber*)canHandleURL:(id)value
{
    return NUMBOOL([[SPTAuth defaultInstance] canHandleURL:[NSURL URLWithString:[TiUtils stringValue:value]]]);
}

MAKE_SYSTEM_STR(AUTH_STREAMING_SCOPE, SPTAuthStreamingScope);
MAKE_SYSTEM_STR(AUTH_PLAYLIST_READ_PRIVATE_SCOPE, SPTAuthPlaylistReadPrivateScope);
MAKE_SYSTEM_STR(AUTH_PLAYLIST_MODIFY_PUBLIC_SCOPE, SPTAuthPlaylistModifyPublicScope);
MAKE_SYSTEM_STR(AUTH_PLAYLIST_MODIFY_PRIVATE_SCOPE, SPTAuthPlaylistModifyPrivateScope);
MAKE_SYSTEM_STR(AUTH_USER_FOLLOW_MODIFY_SCOPE, SPTAuthUserFollowModifyScope);
MAKE_SYSTEM_STR(AUTH_USER_FOLLOW_READ_SCOPE, SPTAuthUserFollowReadScope);
MAKE_SYSTEM_STR(AUTH_USER_LIBRARY_READ_SCOPE, SPTAuthUserLibraryReadScope);
MAKE_SYSTEM_STR(AUTH_USER_LIBRARY_MODIFY_SCOPE, SPTAuthUserLibraryModifyScope);
MAKE_SYSTEM_STR(AUTH_USER_READ_PRIVATE_SCOPE, SPTAuthUserReadPrivateScope);
MAKE_SYSTEM_STR(AUTH_USER_READ_BIRTH_DATE_SCOPE, SPTAuthUserReadBirthDateScope);
MAKE_SYSTEM_STR(AUTH_USER_READ_EMAIL_SCOPE, SPTAuthUserReadEmailScope);

@end
