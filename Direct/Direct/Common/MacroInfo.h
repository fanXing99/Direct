//
//  MacroInfo.h
//  yxzj
//
//  Created by tokee on 15/9/20.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#ifndef yxzj_MacroInfo_h
#define yxzj_MacroInfo_h

#pragma mark - NSObject
#define km_new(Klass) [[Klass alloc] init]
#define km_eql(a,b)   [(a) isEqual:(b)]

#pragma mark - NSArray
#define km_arr(...)   [NSArray arrayWithObjects:__VA_ARGS__, nil]
#define km_marr(...)  [NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define km_marrnew    [NSMutableArray array]

#pragma mark - NSSet
#define km_set(...)   [NSSet setWithObjects:__VA_ARGS__, nil]
#define km_mset(...)  [NSMutableSet setWithObjects:__VA_ARGS__, nil]
#define km_msetnew    [NSMutableSet set]

#pragma mark - NSDictionary
#define km_dict(...)  [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define km_mdict(...) [NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define km_mdictnew   [NSMutableDictionary dictionary]
#define km_str(...)   [NSString stringWithFormat:__VA_ARGS__]
#define km_mstr(...)  [NSMutableString stringWithFormat:__VA_ARGS__]
#define km_mstrnew    [NSMutableString string]

#pragma mark - NSNumber
#define km_bool(val)      [NSNumber numberWithBool:(val)]
#define km_char(val)      [NSNumber numberWithChar:(val)]
#define km_double(val)    [NSNumber numberWithDouble:(val)]
#define km_float(val)     [NSNumber numberWithFloat:(val)]
#define km_int(val)       [NSNumber numberWithInt:(val)]
#define km_integer(val)   [NSNumber numberWithInteger:(val)]
#define km_long(val)      [NSNumber numberWithLong:(val)]
#define km_longlong(val)  [NSNumber numberWithLongLong:(val)]
#define km_short(val)     [NSNumber numberWithShort:(val)]
#define km_uchar(val)     [NSNumber numberWithUnsignedChar:(val)]
#define km_uint(val)      [NSNumber numberWithUnsignedInt:(val)]
#define km_uinteger(val)  [NSNumber numberWithUnsignedInteger:(val)]
#define km_ulong(val)     [NSNumber numberWithUnsignedLong:(val)]
#define km_ulonglong(val) [NSNumber numberWithUnsignedLongLong:(val)]
#define km_ushort(val)    [NSNumber numberWithUnsignedShort:(val)]

#pragma mark - NSValue
#define km_nonretained(val) [NSValue valueWithNonretainedObject:(val)]
#define km_pointer(val)     [NSValue valueWithPointer:(val)]
#define km_point(val)       [NSValue valueWithPoint:(val)]
#define km_range(val)       [NSValue valueWithRange:(val)]
#define km_rect(val)        [NSValue valueWithRect:(val)]
#define km_size(val)        [NSValue valueWithSize:(val)]

#pragma mark - Check
#define km_safe(obj)        ((NSNull *)(obj) == [NSNull null] ? nil : (obj))

#pragma mark - NSError
#define km_error(msg)       [NSError errorWithDomain:@"com.tokee.tf.error" code:1 userInfo:[NSDictionary dictionaryWithObject:msg                                                                      forKey:NSLocalizedDescriptionKey]]

#pragma mark - Device
#define km_nav_height       44
#define km_tab_height       49
#define km_screen_width     ([UIScreen mainScreen].bounds.size.width)
#define km_screen_height    ([UIScreen mainScreen].bounds.size.height)
#define km_ios_version      [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - UIImage
#define km_image_file(file)     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:nil]]
#define km_image_fext(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define km_image(name)          [UIImage imageNamed:name]

#pragma mark - UIColor
#define km_rgb(r, g, b)         [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define km_rgba(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define km_rgb_hex(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define km_rgba_hex(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#pragma mark - Tel
#define km_tel(phoneNumber)         ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define km_tel_prompt(phoneNumber)  ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])

#pragma mark - Url
#define km_open_url(appScheme)      ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])

#endif
