//
//  Format.h
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Format : NSObject <NSCoding>

@property                       int         idFormat;
@property   (strong,nonatomic)  NSString*   intitule;
@property   (nonatomic)         float       tarif;
@property   (nonatomic)         float       width;
@property   (nonatomic)         float       length;

@end
