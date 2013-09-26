//
//  GBRelatedInformationView.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBRelatedInformationView.h"
@interface GBRelatedInformationView()

@property (nonatomic, strong) UIWebView *webView;

@end


@implementation GBRelatedInformationView
#pragma mark - Property Accessors
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.frame];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        _webView.delegate = self;
        [self addSubview:_webView];
    }
    return _webView;
}

- (void)setSubject:(NSString *)subject
{
    if (![_subject isEqualToString:subject]) {
        _subject = subject;
        NSString *urlString = [NSString stringWithFormat:@"http://bigab.net/%@", [self urlEncode:subject]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [self.webView loadRequest:request];
    }
}

#pragma mark - Init
- (void)_init
{
    self.webView.delegate = self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

#pragma mark - String stuff
- (NSString *)urlEncode:(NSString *)string
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    aWebView.scrollView.scrollEnabled = YES;
    CGRect frame = aWebView.frame;
    
    frame.size.width = 200;       // Your desired width here.
    frame.size.height = 1;        // Set the height to a small one.
    
    aWebView.frame = frame;       // Set webView's Frame, forcing the Layout of its embedded scrollView with current Frame's constraints (Width set above).
    CGSize contentSize = aWebView.scrollView.contentSize;
    frame.size.height = contentSize.height;  // Get the corresponding height from the webView's embedded scrollView.
    
    aWebView.frame = frame;
    
    NSLog(@"fitting size: %@", [NSValue valueWithCGSize:frame.size]);
}

@end
