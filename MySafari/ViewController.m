//
//  ViewController.m
//  MySafari
//
//  Created by Yemi Ajibola on 1/12/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urlDisplayed:@"http://google.com"];
}
-(void) urlDisplayed:(NSString*)string{
    NSURL *webSite = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:webSite];
    [self.webView loadRequest:request];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self urlDisplayed:textField.text];
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
}


@end
