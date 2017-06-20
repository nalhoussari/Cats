//
//  ViewController.m
//  Cats2
//
//  Created by Noor Alhoussari on 2017-06-19.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "PhotoCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *photosArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    NSString *urlString = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=18a52408f59a386576e3abe19440cbb0&tags=cat";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            //because photos are dictionary inside it dictionaryies. Photo is an array insdie photos that contain dictionary objects:
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSDictionary *photos = json[@"photos"];
            NSArray * photo = photos[@"photo"];
            
            self.photosArray = [NSMutableArray array];
            
            for (NSDictionary *eachPhoto in photo){
                // server, farm, id, and secret
                NSString *server = eachPhoto[@"server"];
                NSNumber *farm = eachPhoto[@"farm"];
                NSString *iD = eachPhoto[@"id"];
                NSString *secret = eachPhoto[@"secret"];
                NSString *title = eachPhoto[@"title"];
                
                Photo* aPhoto = [[Photo alloc] initWithServer:server andFarm:farm andId:iD andSecret:secret andTitle:title];
                //NSLog(@"aPhoto is %@", aPhoto.title);
                
                [self.photosArray addObject:aPhoto];
            }
            
//            dispatch_async(dispatch_get_main_queue(), ^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
//            });
        }
    }];

    [dataTask resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    Photo *photo = self.photosArray[indexPath.item];
    
    //setting the cell's title
    NSString *stringTitle = [self.photosArray[indexPath.item] title];
    
    //setting the cell's image

    //checking if the photo has been downloaded, if it has, assign the cell.image to the property of Photo class that already storing the downloaded image.
    if(photo.catImage == nil){
    
    NSString *imageURLString = [self.photosArray[indexPath.item] urlString];
    NSURL *url = [NSURL URLWithString:imageURLString];
    
//    NSData *data = [NSData dataWithContentsOfURL:url];

    // we ommited downloading the images from NSData right away, as its better to use ot local file instead,  as it might take a lot of time to downlaod if any item needed time to. And it won't accept working till everythng is downlaoded. So otherwise, we can use: 1.setting up url session, 2.setup download task with image URL, 3.download asynchronously and 4.update cell with image in callback, as follows:
    
    // setup url session
    NSURLSession *session = [NSURLSession sharedSession];

    // setup download task with image URL
    // download asynchronously and wait for callback (completion handler)
    
    NSURLSessionDownloadTask *downloadPhotoTask = [session downloadTaskWithURL:url
                                                           completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                               // update cell with image in callback.
                                                               NSData *data = [NSData dataWithContentsOfURL:url];
                                                               
                                                               [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                   //to cure a small bug: because this Block won't be excuted till the other code out side are excuted, we need to call the photoCell at the indexPath to catch the cell before returning it!
                                                                   PhotoCell * cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
                                                                   
                                                               photo.catImage = [UIImage imageWithData:data];
                                                               cell.catImage.image = photo.catImage;
                                                               }];
                                                               }];
    [downloadPhotoTask resume];
    } else {
        cell.catImage.image = photo.catImage;
    }
    cell.title.text = stringTitle;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
