//
//  ALAssetsLibrary category to handle a custom photo album
//
//  Created by Marin Todorov on 10/26/11.
//  Copyright (c) 2011 Marin Todorov. All rights reserved.
//

#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@implementation ALAssetsLibrary (CustomPhotoAlbum)

- (void)saveImage:(UIImage *)image toAlbum:(NSString *)albumName withCompletionBlock:(SaveImageCompletion)completionBlock {
    //write the image data to the assets library (camera roll)
    [self writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation) image.imageOrientation
                       completionBlock:^(NSURL *assetURL, NSError *error) {

                           //error handling
                           if (error != nil) {
                               completionBlock(error);
                               return;
                           }

                           //add the asset to the custom photo album
                           [self addAssetURL:assetURL
                                     toAlbum:albumName
                         withCompletionBlock:completionBlock];

                       }];
}

- (void)addAssetURL:(NSURL *)assetURL toAlbum:(NSString *)albumName withCompletionBlock:(SaveImageCompletion)completionBlock {
    __block BOOL albumWasFound = NO;
    __block int i = 0;
    //search all photo albums in the library
    [self enumerateGroupsWithTypes:ALAssetsGroupAlbum
                        usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                            NSString *ssss = [group valueForProperty:ALAssetsGroupPropertyName];
                            //compare the names of the albums
                            NSLog(@"group = %@, sss= %@, i = %d", group, ssss, ++i);
                            if ([albumName compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame) {

                                //target album is found
                                albumWasFound = YES;

                                //get a hold of the photo's asset instance
                                [self assetForURL:assetURL
                                      resultBlock:^(ALAsset *asset) {
                                          NSLog(@"add success %d", i);
                                          //add photo to the target album
                                          [group addAsset:asset];

                                          //run the completion block
                                          completionBlock(nil);

                                      } failureBlock:completionBlock];

                                //album was found, bail out of the method
                                return;
                            }

                            if (group == nil && albumWasFound == NO) {
                                //photo albums are over, target album does not exist, thus create it

                                __weak ALAssetsLibrary *weakSelf = self;
//								[TSMessage showNotificationWithTitle:@"又创建了一个小加的相册" type:TSMessageNotificationTypeWarning]; // todo ...
                                NSLog(@"add addAssetsGroupAlbumWithName ");
                                //create new assets album
                                [self addAssetsGroupAlbumWithName:albumName
                                                      resultBlock:^(ALAssetsGroup *group) {

                                                          //get the photo's instance
                                                          [weakSelf assetForURL:assetURL
                                                                    resultBlock:^(ALAsset *asset) {

                                                                        //add photo to the newly created album
                                                                        [group addAsset:asset];

                                                                        //call the completion block
                                                                        completionBlock(nil);

                                                                    } failureBlock:completionBlock];

                                                      } failureBlock:completionBlock];

                                //should be the last iteration anyway, but just in case
                                return;
                            }

                        } failureBlock:completionBlock];

}

@end
