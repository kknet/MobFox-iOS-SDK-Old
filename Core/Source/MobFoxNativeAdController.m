//
//  MobFoxNativeAdController.m
//  MobFoxSDKSource
//
//  Created by Michał Kapuściński on 21.05.2014.
//
//

#import "MobFoxNativeAdController.h"
#import "NSString+MobFox.h"
#import "NSURL+MobFox.h"
#import "UIDevice+IdentifierAddition.h"
#import <AdSupport/AdSupport.h>
#import "NativeAd.h"
#import <UIKit/UIKit.h>
#import "MobFoxNativeTrackingView.h"


NSString * const MobFoxNativeAdErrorDomain = @"MobFoxNativeAd";
int const MAX_STARS = 5;

@interface MobFoxNativeAdController () {
    
}


@property (nonatomic, strong) NSString *userAgent;
@property (nonatomic, strong) NSMutableDictionary *browserUserAgentDict;
@property (nonatomic, assign) CGFloat currentLatitude;
@property (nonatomic, assign) CGFloat currentLongitude;
@property (nonatomic, strong) NSString *clickUrl;
@property (nonatomic, strong) NSString *IPAddress;

@end



@implementation MobFoxNativeAdController


- (void) setup
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    [self setUpBrowserUserAgentStrings];
    self.IPAddress = [self returnDeviceIPAddress];
}

- (id)init
{
    self = [super init];
    [self setup];
    return self;
}

- (void)setUpBrowserUserAgentStrings {
    
    NSArray *array;
    self.browserUserAgentDict = [NSMutableDictionary dictionaryWithCapacity:0];
	array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.2.2"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.2.1"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.2"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.9"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.8"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.7"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.6"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.5"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.4"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.3"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.2"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1.1"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.1"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.0.2"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.0.1"];
    array = @[@" Version/6.0", @" Safari/8536.25"];
    [self.browserUserAgentDict setObject:array forKey:@"6.0"];
    array = @[@" Version/5.1", @" Safari/7534.48.3"];
    [self.browserUserAgentDict setObject:array forKey:@"5.1.1"];
    array = @[@" Version/5.1", @" Safari/7534.48.3"];
    [self.browserUserAgentDict setObject:array forKey:@"5.1"];
    array = @[@" Version/5.1", @" Safari/7534.48.3"];
    [self.browserUserAgentDict setObject:array forKey:@"5.0.1"];
    array = @[@" Version/5.1", @" Safari/7534.48.3"];
    [self.browserUserAgentDict setObject:array forKey:@"5.0"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.3.5"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.3.4"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.3.3"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.3.2"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.3.1"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.3"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.10"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.9"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.8"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.7"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.6"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.5"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2.1"];
    array = @[@" Version/5.0.2", @" Safari/6533.18.5"];
    [self.browserUserAgentDict setObject:array forKey:@"4.2"];
    array = @[@" Version/4.0.5", @" Safari/6531.22.7"];
    [self.browserUserAgentDict setObject:array forKey:@"4.1"];
    
}

- (NSString*)browserAgentString
{
    
    NSString *osVersion = [UIDevice currentDevice].systemVersion;
    NSArray *agentStringArray = self.browserUserAgentDict[osVersion];
    NSMutableString *agentString = [NSMutableString stringWithString:self.userAgent];
    
    NSRange range = [agentString rangeOfString:@"like Gecko)"];
    
    if (range.location != NSNotFound && range.length) {
        
        NSInteger theIndex = range.location + range.length;
        
		if ([agentStringArray objectAtIndex:0]) {
			[agentString insertString:[agentStringArray objectAtIndex:0] atIndex:theIndex];
			[agentString appendString:[agentStringArray objectAtIndex:1]];
		}
        else {
			[agentString insertString:@" Version/unknown" atIndex:theIndex];
			[agentString appendString:@" Safari/unknown"];
		}
        
    }
    
    return agentString;
}

- (void)requestAd
{
    
    if (!delegate)
	{
		return;
	}
	if (![delegate respondsToSelector:@selector(publisherIdForMobFoxNativeAdController:)])
	{
		return;
	}
	NSString *publisherId = [delegate publisherIdForMobFoxNativeAdController:self];
	if (![publisherId length])
	{

        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Invalid publsher ID supplied" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:MobFoxNativeAdErrorDomain code:0 userInfo:userInfo];
        [self performSelectorOnMainThread:@selector(reportError:) withObject:error waitUntilDone:YES];
        
		return;
	}
	[self performSelectorInBackground:@selector(asyncRequestAdWithPublisherId:) withObject:publisherId];
}

- (void)asyncRequestAdWithPublisherId:(NSString *)publisherId
{
	@autoreleasepool
	{
        NSString *osVersion = [UIDevice currentDevice].systemVersion;
        
        NSString *requestString;
        NSString *adTypesString = [adTypes componentsJoinedByString:@","];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        NSString *iosadvid;
        if ([ASIdentifierManager instancesRespondToSelector:@selector(advertisingIdentifier )]) {
            iosadvid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

            requestString=[NSString stringWithFormat:@"r_type=native&r_resp=json&n_img=icon,main&n_txt=headline,description,cta,advertiser,rating&n_type=%@&u=%@&i=%@&u_wv=%@&u_br=%@&o_iosadvid=%@&v=%@&s=%@&iphone_osversion=%@",
                           [adTypesString stringByUrlEncoding],
						   [self.userAgent stringByUrlEncoding],
                           [self.IPAddress stringByUrlEncoding],
						   [self.userAgent stringByUrlEncoding],
						   [[self browserAgentString] stringByUrlEncoding],
						   [iosadvid stringByUrlEncoding],
						   [SDK_VERSION stringByUrlEncoding],
						   [publisherId stringByUrlEncoding],
						   [osVersion stringByUrlEncoding]];
            
        } else {
            requestString=[NSString stringWithFormat:@"r_type=native&r_resp=json&n_img=icon,main&n_txt=headline,description,cta,advertiser,rating&n_type=%@&u=%@&i=%@&u_wv=%@&u_br=%@&&v=%@&s=%@&iphone_osversion=%@",
                           [adTypesString stringByUrlEncoding],
						   [self.userAgent stringByUrlEncoding],
                           [self.IPAddress stringByUrlEncoding],
						   [self.userAgent stringByUrlEncoding],
						   [[self browserAgentString] stringByUrlEncoding],
						   [SDK_VERSION stringByUrlEncoding],
						   [publisherId stringByUrlEncoding],
						   [osVersion stringByUrlEncoding]];
			
            
        }
#else
        
        requestString=[NSString stringWithFormat:@"r_type=native&r_resp=json&n_img=icon,main&n_txt=headline,description,cta,advertiser,rating&n_type=%@&u=%@&i=%@&u_wv=%@&u_br=%@&&v=%@&s=%@&iphone_osversion=%@",
                       [adTypesString stringByUrlEncoding],
                       [self.userAgent stringByUrlEncoding],
                       [self.IPAddress stringByUrlEncoding],
                       [self.userAgent stringByUrlEncoding],
                       [[self browserAgentString] stringByUrlEncoding],
                       [SDK_VERSION stringByUrlEncoding],
                       [publisherId stringByUrlEncoding],
                       [osVersion stringByUrlEncoding]];
        
#endif
        NSString *requestStringWithLocation;
        if(locationAwareAdverts && self.currentLatitude && self.currentLongitude)
        {
            NSString *latitudeString = [NSString stringWithFormat:@"%+.6f", self.currentLatitude];
            NSString *longitudeString = [NSString stringWithFormat:@"%+.6f", self.currentLongitude];
            
            requestStringWithLocation = [NSString stringWithFormat:@"%@&latitude=%@&longitude=%@",
                                         requestString,
                                         [latitudeString stringByUrlEncoding],
                                         [longitudeString stringByUrlEncoding]
                                         ];
        }
        else
        {
            requestStringWithLocation = requestString;
        }
        
        
        if([userGender isEqualToString:@"female"]) {
            requestStringWithLocation = [NSString stringWithFormat:@"%@&demo.gender=f",
                                 requestStringWithLocation];
        } else if([userGender isEqualToString:@"male"]) {
            requestStringWithLocation = [NSString stringWithFormat:@"%@&demo.gender=m",
                                 requestStringWithLocation];
        }
        if(userAge) {
            NSString *age = [NSString stringWithFormat:@"%d",(int)userAge];
            requestStringWithLocation = [NSString stringWithFormat:@"%@&demo.age=%@",
                                 requestStringWithLocation,
                                 [age stringByUrlEncoding]];
        }
        if(keywords) {
            NSString *words = [keywords componentsJoinedByString:@","];
            requestStringWithLocation = [NSString stringWithFormat:@"%@&demo.keywords=%@",
                                 requestStringWithLocation,
                                 words];
            
        }
        
        NSURL *serverURL = [self serverURL];
        
        if (!serverURL) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Error - no or invalid requestURL. Please set requestURL" forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:MobFoxNativeAdErrorDomain code:0 userInfo:userInfo];
            [self performSelectorOnMainThread:@selector(reportError:) withObject:error waitUntilDone:YES];
            return;
        }
        
        NSURL *url;
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", serverURL, requestStringWithLocation]];
        
        
        NSMutableURLRequest *request;
        NSError *error;
        NSURLResponse *response;
        NSData *dataReply;
        
        request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod: @"GET"];
//        [request setValue:@"text/xml" forHTTPHeaderField:@"Accept"];
        [request setValue:self.userAgent forHTTPHeaderField:@"User-Agent"];
        
        dataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSError *localError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataReply options:0 error:&localError];
        
        if (!json || error)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Error parsing JSON response from server" forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:MobFoxNativeAdErrorDomain code:0 userInfo:userInfo];
            [self performSelectorOnMainThread:@selector(reportError:) withObject:error waitUntilDone:YES];
            return;
        }
        
        [self setupAdFromJson:json];
	}
    
}

- (void)setupAdFromJson:(NSDictionary *)json
{
    NativeAd *ad = [[NativeAd alloc]init];
    ad.clickUrl = json[@"click_url"];
    
    NSDictionary* imageAssets = json[@"imageassets"];
    NSEnumerator* imageAssetEnumerator = [imageAssets keyEnumerator];
    NSString* key;
    while (key = [imageAssetEnumerator nextObject]) {
        ImageAsset* asset = [[ImageAsset alloc]init];
        NSDictionary* assetObject = imageAssets[key];
        NSString* imageUrl = assetObject[@"url"];
        asset.url = imageUrl;
        asset.image = [self downloadImageFromUrl:imageUrl];
        asset.width =  assetObject[@"width"];
        asset.height = assetObject[@"height"];
        [ad.imageAssets setObject:asset forKey:key];
    }
    
    NSDictionary* textAssets = json[@"textassets"];
    NSEnumerator* textAssetEnumerator = [textAssets keyEnumerator];
    while (key = [textAssetEnumerator nextObject]) {
        NSString* url = textAssets[key];
        [ad.textAssets setObject:url forKey:key];
    }
    
    NSArray* trackersArray = json[@"trackers"];
    for (NSDictionary* trackerObject in trackersArray){
        Tracker* tracker = [[Tracker alloc]init];
        tracker.type = trackerObject[@"type"];
        tracker.url = trackerObject[@"url"];
        [ad.trackers addObject:tracker];
    }

    [self performSelectorOnMainThread:@selector(reportSuccess:) withObject:ad waitUntilDone:YES];
}

-(UIImage*)downloadImageFromUrl:(NSString*)url {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    result = [UIImage imageWithData:data];
    
    return result;
}

-(UIView *)getNativeAdViewForResponse:(NativeAd *)response xibName:(NSString *)name {
    
    if(!response) {
        return nil;
    }
    
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    UIView* mainView = nibObjects[0];
    
    
    NSMutableArray* impressionTrackers = [[NSMutableArray alloc]init];
    for (Tracker* t in response.trackers) {
        if([t.type isEqualToString:@"impression"]) {
            [impressionTrackers addObject:t.url];
        }
    }
    
    MobFoxNativeTrackingView* trackingView = [[MobFoxNativeTrackingView alloc] initWithFrame:mainView.frame]; //Invisible view, used for tracking impressions
    trackingView.impressionTrackers = impressionTrackers;
    trackingView.delegate = delegate;
    [mainView addSubview:trackingView];
    
    for (UIView *child in mainView.subviews) {
        
        NSString* textAssetName = [child valueForKey:@"MobFoxTextAsset"];
        NSString* imageAssetName = [child valueForKey:@"MobFoxImageAsset"];
        
        if(textAssetName && [child isKindOfClass:[UILabel class]]) {
            NSString* text = [response.textAssets objectForKey:textAssetName];
            if([textAssetName isEqualToString:@"rating"] && text) {
                int fullStars = [text intValue];
                int emptyStars = MAX_STARS - fullStars;
                NSMutableString* starsLabel = [[NSMutableString alloc] init];
                for (int i=0; i<fullStars; i++) {
                    [starsLabel appendString:@"★"];
                }
                for (int i=0; i<emptyStars; i++) {
                    [starsLabel appendString:@"☆"];
                }
                ((UILabel*)child).text = starsLabel;
            } else {
                ((UILabel*)child).text = text;
            }
        } else if(imageAssetName && [child isKindOfClass:[UIImageView class]]){
            ImageAsset* asset = [response.imageAssets objectForKey:imageAssetName];
            if(asset.image) {
                ((UIImageView*)child).image = asset.image;
            }
        }
   
    }
    
    
    clickUrl = response.clickUrl;
    
    if(clickUrl) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [mainView addGestureRecognizer:tap];
    }
    
    return mainView;

}


- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    [self performSelectorOnMainThread:@selector(reportClick) withObject:nil waitUntilDone:YES];
    NSURL *clickURL = [NSURL URLWithString:clickUrl];
    [[UIApplication sharedApplication]openURL:clickURL];
}

- (void)reportError:(NSError *)error
{
	if ([delegate respondsToSelector:@selector(nativeAdFailedToLoadWithError:)])
    {
        [delegate nativeAdFailedToLoadWithError:error];
    }
}

- (void)reportSuccess:(NativeAd *)ad
{
	if ([delegate respondsToSelector:@selector(nativeAdDidLoad:)])
	{
		[delegate nativeAdDidLoad:ad];
	}
}

- (void)reportClick
{
	if ([delegate respondsToSelector:@selector(nativeAdWasClicked)])
	{
		[delegate nativeAdWasClicked];
	}
}


- (void)setLocationWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude {
    self.currentLatitude = latitude;
    self.currentLongitude = longitude;
}

- (NSURL *)serverURL
{
	return [NSURL URLWithString:self.requestURL];
}

- (NSString*)returnDeviceIPAddress {
    
    NSString *IPAddressToReturn;
    
#if TARGET_IPHONE_SIMULATOR
    IPAddressToReturn = [UIDevice localSimulatorIPAddress];
#else
    
    IPAddressToReturn = [UIDevice localWiFiIPAddress];
    
    if(!IPAddressToReturn) {
        IPAddressToReturn = [UIDevice localCellularIPAddress];
    }
    
#endif
    
    return IPAddressToReturn;
}


@synthesize delegate;
@synthesize requestURL;
@synthesize clickUrl;
@synthesize locationAwareAdverts;
@synthesize userAge, userGender, keywords;
@synthesize adTypes;
@synthesize IPAddress;

@end
