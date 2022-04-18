//
//  Watcher.m
//  Watcher
//
//  Created by Charlie Robin on 06/12/2019.
//  Copyright © 2019 Charlie Robin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (*handler)(uint64_t, char*, unsigned long);

NSMutableArray *g_Paths;
handler g_CallbackFunction;
FSEventStreamRef g_Stream;

void mycallback( ConstFSEventStreamRef streamRef, void *clientCallBackInfo, size_t numEvents, void *eventPaths, const FSEventStreamEventFlags eventFlags[], const FSEventStreamEventId eventIds[] )
{
    // https://developer.apple.com/documentation/coreservices/1455361-fseventstreameventflags
    
    char **paths = eventPaths;
    
    for ( int i = 0; i < numEvents; i++ )
    {
        unsigned long flags = eventFlags[ i ];
        g_CallbackFunction( eventIds[ i ], paths[ i ], flags );
    }
}

void run()
{
    void *callbackInfo = NULL;
    
    CFAbsoluteTime latency = 5.0;
    
    CFArrayRef pathsToWatch = (__bridge CFArrayRef _Nonnull)( g_Paths );
    
    // https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
    
    // https://developer.apple.com/documentation/coreservices/1455376-fseventstreamcreateflags
    
    g_Stream = FSEventStreamCreate( NULL, &mycallback, callbackInfo, pathsToWatch, kFSEventStreamEventIdSinceNow, latency, kFSEventStreamCreateFlagFileEvents );
    
    FSEventStreamScheduleWithRunLoop( g_Stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode );
    
    FSEventStreamStart( g_Stream );
    
    CFRunLoopRun();
}

void stop()
{
    if ( g_Stream != NULL )
    {
        FSEventStreamStop( g_Stream );
        FSEventStreamUnscheduleFromRunLoop( g_Stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode );
        FSEventStreamInvalidate( g_Stream );
        FSEventStreamRelease( g_Stream );
        g_Stream = NULL;
    }
}

void clearPaths()
{
    if ( g_Paths == NULL )
    {
        g_Paths = [[NSMutableArray alloc] init];
    }
    
    [g_Paths removeAllObjects];
}

void addPath( NSString *path )
{
    [g_Paths addObject:path];
}

void installCallback( handler pointer )
{
    g_CallbackFunction = pointer;
}


