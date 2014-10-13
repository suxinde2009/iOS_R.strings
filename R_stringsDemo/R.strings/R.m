/*
 The MIT License (MIT)
 
 Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "R.h"

@implementation R

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (NSString *)string:(NSString *)key
{
    NSArray *dictArray = mDictionary[@"string"];
    for(id o in dictArray){
        NSString *nameByKey = [o valueForKey:@"_name"];
        if ([nameByKey isEqualToString:key]) {
            NSString *strByKey = [o valueForKey:@"__text"];
            return strByKey;
            //NSLog(@"%@", [o valueForKey:@"__text"]);
        }
    }
    return nil;
}

- (void)loadXmlByFileName:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSString *xmlString = [[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL] autorelease];
    //NSLog(@"%s string: %@", __func__, xmlString);
    [self loadXml:xmlString];
}

- (void)loadXml:(NSString *)xml
{
    if (mDictionary) {
        [mDictionary release];
        mDictionary = nil;
    }
    
    mDictionary = [[[self class] dictionaryWithXMLString:xml] retain];
}

+ (NSDictionary *)dictionaryWithXMLString:(NSString *)xmlStr
{
    return [NSDictionary dictionaryWithXMLString:xmlStr];
}


@end
