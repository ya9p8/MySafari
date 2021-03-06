//
//  ViewController.m
//  MySafari
//
//  Created by Yemi Ajibola on 1/12/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urlDisplayed:@"http://www.google.com"];
    self.webView.scrollView.delegate = self;
    
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
        NSString* appendedString = [NSString stringWithFormat:@"http://%@", textField.text];
         [self urlDisplayed:appendedString];
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
    self.urlTextField.text = self.webView.request.URL.absoluteString;
    self.navigationBar.topItem.title = self.webView.request.URL.host;
    [self.urlTextField setHidden:false];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.urlTextField setHidden:true];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.urlTextField setHidden:false];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.urlTextField setHidden:false];
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

- (IBAction)comingSoonButtonPressed:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Coming Soon!" message:@"NEW CHANGES COMING SOON!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:true completion:nil];
    
}

- (IBAction)clearTextField:(id)sender {
    self.urlTextField.text = nil;
}


@end
