//
//  LogUtil.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LogDebug( format, ... )		NSLog(@"%@", [NSString stringWithFormat:(format), ##__VA_ARGS__])
#define LogInfo( format, ... )		NSLog(@"%@", [NSString stringWithFormat:(format), ##__VA_ARGS__])
#define LogError( format, ... )		NSLog(@"%@", [NSString stringWithFormat:(format), ##__VA_ARGS__])

@interface LogUtil : NSObject

@end
