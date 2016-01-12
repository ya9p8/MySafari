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
//@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urlDisplayed:@"http://www.google.com"];
}
-(void) urlDisplayed:(NSString*)string{
    NSURL *webSite = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:webSite];
    [self.webView loadRequest:request];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField.text containsString:@"http://"]){
    [self urlDisplayed:textField.text];
    }else{
        
    }
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
    if(webView.canGoBack == true){
        self.backButton.enabled = true;
    }else{
        self.backButton.enabled = false;
    }
    if(webView.canGoForward == true){
        self.forwardButton.enabled = true;
    }else{
        self.forwardButton.enabled = false;
    }
}

- (IBAction)onBackButtonPressed:(id)sender {
        [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

@end
