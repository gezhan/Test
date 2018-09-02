//
//  HSSystem.m
//  WinShare
//
//  Created by GZH on 2017/5/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "HSSystem.h"

@implementation HSSystem

+ (NSString *)iOSSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+ (NSString *)buildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

+ (BOOL)iOS8
{
    return [self iOSVersion:8.0];
}


+ (BOOL)iOSVersion:(CGFloat)version
{
    return [self iOSSystemVersion].floatValue >= version && [self iOSSystemVersion].floatValue < version+1;
}


+ (BOOL)isJailbrokenUser

{
    /* Cydia.app */
    NSString *cydiaPath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    
    /* apt */
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPiratedUser
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/iTunesMetadata.plist"];
    NSDictionary *infoDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    if (infoDic[@"com.apple.iTunesStore.downloadInfo"][@"accountInfo"][@"AppleID"]) {
        return NO;
    } else if (infoDic[@"appleId"])
    {
        return NO;
    } else {
        return YES;
    }
}

@end
