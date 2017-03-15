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
#import "TiApp.h"
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>

@interface TiApp (TiSpotifyApp)

@end

@implementation TiApp (TiSpotifyApp)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    if ([[SPTAuth defaultInstance] canHandleURL:url]) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kTiSpotifyNotification object:@{
                @"session": session,
                @"error": error
            }];
        }];
        return YES;
    }
    
    return NO;
}

@end

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

+ (void)load
{
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(handleAuthCallback:)
                                                name:kTiSpotifyNotification
                                              object:nil];
   [super load];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark Private APIs

- (void)handleAuthCallback:(NSNotification *)notification
{
    if ([notification name] != kTiSpotifyNotification) {
        NSLog(@"Received unknown notification: %@ with object: %@", [notification name], [notification object]);
        return;
    }
    
    NSDictionary *dict = (NSDictionary*)[notification object];
    NSError *error = [dict objectForKey:@"error"];
    SPTSession *session = [dict objectForKey:@"session"];
    
    if (error) {
        [self fireEvent:@"login" withObject:@{
            @"success": NUMBOOL(NO),
            @"error": [error localizedDescription]
        }];
    } else {
        [self fireEvent:@"login" withObject:@{
            @"success": NUMBOOL(YES),
            @"user": [self dictionaryFromUserSession:session]
        }];
    }
}

- (NSDictionary *)dictionaryFromUserSession:(SPTSession *)userSession
{
    return @{
        @"canonicalUserName": [userSession canonicalUsername],
        @"accessToken": [userSession accessToken]
    };
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

- (void)authorize
{
    NSURL *loginURL = [SPTAuth loginURLForClientId:[[SPTAuth defaultInstance] clientID]
                                  withRedirectURL:[[SPTAuth defaultInstance] redirectURL]
                                           scopes:[[SPTAuth defaultInstance] requestedScopes]
                                     responseType:@"code"];
    
    if ([SPTAuth supportsApplicationAuthentication]) {
        [[UIApplication sharedApplication] openURL:loginURL];
    } else {
        // TODO: Only create once and access instance instamce
        SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:[[SPTAuth defaultInstance] spotifyWebAuthenticationURL]];
        safari.delegate = self;
        safari.modalPresentationStyle = UIModalPresentationPageSheet;

        [[TiApp app] showModalController:safari animated:YES];
    }
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

#pragma mark Delegates

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    if ([self _hasListeners:@"login"]) {
        [self fireEvent:@"login" withObject:@{@"cancel": NUMBOOL(YES), @"success": NUMBOOL(NO)}];
    }
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
