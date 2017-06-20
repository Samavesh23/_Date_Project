//
//  Favorite+CoreDataProperties.h
//  
//
//  Created by Yatharth Singh on 24/02/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Favorite+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Favorite (CoreDataProperties)

+ (NSFetchRequest<Favorite *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *datename;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *imageurl;
@property (nullable, nonatomic, copy) NSString *placeid;
@property (nullable, nonatomic, copy) NSString *rating;
@property (nullable, nonatomic, copy) NSString *descriptiontext;
@property (nullable, nonatomic, copy) NSString *isfavorite;
@property (nullable, nonatomic, copy) NSString *websiteurl;
@property (nullable, nonatomic, copy) NSString *day;
@property (nullable, nonatomic, copy) NSString *openingclosing;
@property (nullable, nonatomic, copy) NSString *userid;
@property (nullable, nonatomic, copy) NSString *phonenumber;
@property (nullable, nonatomic, copy) NSString *reviewcount;
@property (nullable, nonatomic, copy) NSString *locationlat;
@property (nullable, nonatomic, copy) NSString *locationlong;

@end

NS_ASSUME_NONNULL_END
