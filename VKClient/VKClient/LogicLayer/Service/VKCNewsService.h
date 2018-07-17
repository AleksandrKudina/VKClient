//
//  VKCNewsService.h
//  VKClient
//
//  Created by Кудина  on 17.07.2018.
//  Copyright © 2018 KudinaAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKCNewsEntity.h"

@interface VKCNewsService : NSObject

- (NSArray<VKCNewsEntity*>*)newsListFromResponse:(NSArray<NSDictionary*>*)response;

@end
