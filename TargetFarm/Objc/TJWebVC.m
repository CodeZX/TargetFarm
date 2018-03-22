//
//  TJWebVC.m
//  HKGoodColor
//
//  Created by chenkaijie on 2018/1/3.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "TJWebVC.h"
#import <WebKit/WebKit.h>

@interface TJWebVC () <WKUIDelegate,WKNavigationDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) CALayer *progresslayer;
@property (weak, nonatomic) UIView *bottomView;
@property (weak, nonatomic) WKWebView *webView;

@end

@implementation TJWebVC

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.urlStr = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupUI {
    
    WKWebView *webView = [[WKWebView alloc]init];
    webView.UIDelegate=self;
    webView.navigationDelegate=self;
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    [self useNSLayoutConstraint_subView:webView spaceToSuperViewUserSafeArea:YES edge:UIEdgeInsetsZero];
    _webView = webView;
    
    
    //添加属性监听
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    //进度条
    UIView *progress = [[UIView alloc]init];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    
    [self setupView:progress];
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor colorWithRed:70.0 / 255 green:165.0 / 255 blue:250.0 / 255 alpha:1.0].CGColor;
    [progress.layer addSublayer:layer];
    _progresslayer = layer;
    
    NSURL *url=[NSURL URLWithString:self.urlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


//加载失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //    [_activityIndicator stopAnimating];
    if (_bottomView == nil) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        bottomView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:bottomView];
        _bottomView = bottomView;
        UITapGestureRecognizer *recongizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
        [bottomView addGestureRecognizer:recongizer];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.center = CGPointMake(bottomView.center.x, bottomView.center.y-64.0);
        //imageView.size = CGSizeMake(bottomView.size.width / 2, bottomView.size.height / 2);
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:@"noData"];
        [bottomView addSubview:imageView];
        //        imageView.sd_layout
        //        .leftEqualToView(bottomView)
        //        .rightEqualToView(bottomView)
        //        .widthIs(100)
        //        .autoHeightRatio(1);
    }else {
        _bottomView.hidden = NO;
    }
}


/** 观察加载进度 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else if ([keyPath isEqualToString:@"title"]){
        self.title = self.webView.title;
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)action {
    _bottomView.hidden = YES;
    if (!_webView.isLoading) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }
}

- (void)onClickBack {
    if (self.webView.canGoBack==YES) {
        
        [self.webView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    NSLog(@"%@", NSStringFromClass([self class]));
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}


- (void)setupView:(UIView *)tempView {
    
    tempView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *superView = tempView.superview;
    
    id item = superView;
    if (@available(iOS 11.0, *)) {
        item = superView.safeAreaLayoutGuide;
    }
    
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:tempView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:tempView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:tempView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:tempView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:3];
    [superView addConstraints:@[left, top, right]];
    [tempView addConstraint:height];
    
}



- (void)useNSLayoutConstraint_subView:(UIView *)subView spaceToSuperViewUserSafeArea:(BOOL)use edge:(UIEdgeInsets)edge {
    if (subView == nil) return;
    
    UIView *superView = subView.superview;
    
    if (superView == nil) return;
    
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        
        id item = use ? superView.safeAreaLayoutGuide : superView;
        
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:edge.left];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:edge.top];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeRight multiplier:1 constant:edge.right];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1 constant:edge.bottom];
        [superView addConstraints:@[left, top, right, bottom]];
    } else {
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:edge.left];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:edge.top];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:edge.right];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:edge.bottom];
        [superView addConstraints:@[left, top, right, bottom]];
    }
}



@end
