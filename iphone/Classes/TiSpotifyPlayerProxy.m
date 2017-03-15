/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSpotifyPlayerProxy.h"
#import "TiUtils.h"

@implementation TiSpotifyPlayerProxy

- (SPTAudioStreamingController *)player
{
    return [SPTAudioStreamingController sharedInstance];
}

#pragma MARK Public APIs

- (void)playTrack:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    id url = [args objectForKey:@"url"];
    id index = [args objectForKey:@"index"];
    id position = [args objectForKey:@"position"];
    id callback = [args objectForKey:@"callback"];
    
    ENSURE_TYPE(url, NSString);
    ENSURE_TYPE_OR_NIL(index, NSNumber);
    ENSURE_TYPE_OR_NIL(position, NSNumber);
    ENSURE_TYPE_OR_NIL(callback, KrollCallback);
    
    [[self player] playSpotifyURI:url
                startingWithIndex:[TiUtils intValue:index]
             startingWithPosition:[TiUtils floatValue:position]
                         callback:^(NSError *error) {
                             if (callback) {
                                 [callback call:@[@{@"success": NUMBOOL(error == nil), @"error": NULL_IF_NIL(error.localizedDescription)}] thisObject:self];
                             }
                         }];
}

- (void)stopTrack:(id)unused
{
    NSError *error;
    [[self player] stopWithError:&error];
    
    if (error) {
        NSLog(@"[ERROR] Could not stop track: %@", error.localizedDescription);
    }
}

@end
