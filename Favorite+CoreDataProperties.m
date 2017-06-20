//
//  Favorite+CoreDataProperties.m
//  
//
//  Created by Yatharth Singh on 24/02/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Favorite+CoreDataProperties.h"

@implementation Favorite (CoreDataProperties)

+ (NSFetchRequest<Favorite *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Favorite"];
}

@dynamic datename;
@dynamic address;
@dynamic imageurl;
@dynamic placeid;
@dynamic rating;
@dynamic descriptiontext;
@dynamic isfavorite;
@dynamic websiteurl;
@dynamic day;
@dynamic openingclosing;
@dynamic userid;
@dynamic phonenumber;
@dynamic reviewcount;
@dynamic locationlat;
@dynamic locationlong;

@end
