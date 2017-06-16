//
//  ViewController.m
//  hitViewText
//
//  Created by 于君 on 15/10/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ViewController.h"
#import "hitView.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)loadView
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    hitView *hit = [[hitView alloc]initWithFrame:CGRectMake(30, 30, 260, 90)];
    hit.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:hit];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)fetchImageWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //调用子UIViewController的方法刷新UI
    NSLog(@"main controller called fetch");
//    [self.backgroundFetchViewController initImageViewWithCompletionHandler:completionHandler];
}
-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}

//把文件拷贝到指定路径
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}

- (void)showImageWithURL:(NSURL *)imageURL
{
    UIImage *image = [UIImage imageWithContentsOfFile:[imageURL path]];
//    self.imageView.image = image;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.hidden = NO;
}

-(void) initImageViewWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Background Fetch View Controller called");
    NSURLSessionDownloadTask *task = [[self session] downloadTaskWithRequest:[self request] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            //            获取新的数据，刷新UI
            NSURL *imageURL = [self createDirectoryForDownloadItemFromURL:location];
            NSLog(@"Fetch image successful, %@",[imageURL path]);
            [self copyTempFileAtURL:location toDestination:imageURL];
            [self showImageWithURL:imageURL];
            //            调用compeletionHandler， 系统会刷新应用在App Switcher中的UI
            completionHandler(UIBackgroundFetchResultNewData);
        }else{
            NSLog(@"Fetch data failed");
            completionHandler(UIBackgroundFetchResultFailed);
        }
    }];
    [task resume];
    
}
- (NSURLSession *)session
{
    //创建NSURLSession
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    return session;
}

- (NSURLRequest *)request
{
    //创建请求
    NSURL *url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/e/e0/Steve_Jobs_with_the_Apple_iPad_no_logo_(cropped).jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}
#pragma mark - uitouch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"" message:@"become key window" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alertV show];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
