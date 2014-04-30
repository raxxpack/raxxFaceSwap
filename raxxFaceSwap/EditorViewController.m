//
//  EditorViewController.m
//  raxxFaceSwap
//
//  Created by Rahim Mitha on 2014-04-30.
//  Copyright (c) 2014 Rahim Mitha. All rights reserved.
//

#import "EditorViewController.h"
#import "TWTSideMenuViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	self.tapGesture.delegate = self;
	
	self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
	self.scrollView.delegate = self;
	[self.scrollView addGestureRecognizer:self.tapGesture];
	[self.view addSubview:self.scrollView];
	
	
	self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SteveJobs.jpg"]];
	self.imageView.frame = (CGRect) {
		.origin = CGPointMake(self.imageView.frame.origin.x, 44),
		.size = self.imageView.image.size
	};
	self.scrollView.contentSize = self.imageView.image.size;
	[self.scrollView addSubview:self.imageView];
	
	UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(selectImage:)];
	
	[[self navigationItem] setRightBarButtonItem:rightButton];
	
	
}

- (void)openButtonPressed {
	[self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (void)selectImage:(id)sender {
	
	UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
	
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera|UIImagePickerControllerSourceTypePhotoLibrary;
	}
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	[self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleTap:(id)sender {

}

#pragma mark -- UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
	self.imageView.image = image;
	self.imageView.frame = (CGRect) {
		.origin = CGPointMake(self.imageView.frame.origin.x, 44),
		.size = self.imageView.image.size
	};
	self.scrollView.contentSize = self.imageView.frame.size;
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIScrollView delegate methods




@end