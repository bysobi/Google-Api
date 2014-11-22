//
//  ViewController.m
//  Developers
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Petrenko Pavel. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *displayName;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GPPSignIn sharedInstance].delegate = self;
    [[GPPSignIn sharedInstance] trySilentAuthentication];
    
}
-(IBAction)signOut:(id)sender{
    [[GPPSignIn sharedInstance] signOut];
    self.profileImage.image = nil;
    self.displayName.text = nil;
}
-(IBAction)disconnect:(id)sender{
    [[GPPSignIn sharedInstance] disconnect];
}
-(void)didDisconnectWithError:(NSError *)error{
    if(!error){
        self.profileImage.image = nil;
        self.displayName.text = nil;
    }
}
-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
    [[[GPPSignIn sharedInstance] plusService]
executeQuery:[GTLQueryPlus queryForPeopleGetWithUserId:@"me"] completionHandler:^(GTLServiceTicket *ticket, GTLPlusPerson *person, NSError *error) {
    
    self.profileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:person.image.url]]];
    self.displayName.text = person.displayName;
    
}];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
