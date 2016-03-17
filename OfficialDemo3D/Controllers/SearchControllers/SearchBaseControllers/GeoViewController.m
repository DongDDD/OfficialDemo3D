//
//  GeoViewController.m
//  officialDemo2D
//
//  Created by PC on 15/8/27.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "GeoViewController.h"
#import "GeocodeAnnotation.h"
#import "GeoDetailViewController.h"
#import "CommonUtility.h"
#import "ViewController.h"
#import "HZAreaPickerView.h"
#import "BaseMapViewController.h"

@interface GeoViewController() <UITextFieldDelegate,HZAreaPickerDelegate,HZAreaPickerDatasource>

@property (nonatomic, strong) UIButton *tapButton;
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (nonatomic,strong)  UITextField *areaText;
@property (nonatomic,retain) AMapGeocodeSearchRequest *geo;
@property (nonatomic,retain) UIButton *okBtn;
@property(nonatomic,retain) UITextField *adressMassage;

-(void)cancelLocatePicker;
@end

@implementation GeoViewController



-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        //        _areaValue = [areaValue retain];
//        self.areaText.text = areaValue;
    }
}

-(void)setCityValue:(NSString *)cityValue
{
    if (![_cityValue isEqualToString:cityValue]) {
        //        _cityValue = [cityValue retain];
//        self.cityText.text = cityValue;
        
    }
}

- (void)viewDidUnload
{
//    [self setAreaText:nil];
//    [self setCityText:nil];
    [self cancelLocatePicker];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
//    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
//        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
//    } else{
//        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
//    }
//    
//    self.geo = [[AMapGeocodeSearchRequest alloc] init];
    self.geo.address = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    //区域拼接完毕然后传给定义好的areaStr先装好，等待继续拼接
    self.areaStr=[NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    self.areaText.text=self.areaStr;
    [self.search AMapGeocodeSearch:_geo];
}

-(NSArray *)areaPickerData:(HZAreaPickerView *)picker
{
    NSArray *data;
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]] ;
    } else{
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    }
    return data;
}



-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.areaText.frame = CGRectMake(0, self.view.bounds.size.height*0.8+50, CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.1-20);
        self.okBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.8-3, self.view.bounds.size.height*0.8+50, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20);
        self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.8+50, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
    }];

    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}

#pragma mark - TextField delegate
//text 被点击就执行
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if ([textField isEqual:self.areaText]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict
                                                       withDelegate:self
                                                      andDatasource:self];
        [self.locatePicker showInView:self.view];
//    } else {
    
//        [self cancelLocatePicker];
//        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity
//                                                       withDelegate:self
//                                                      andDatasource:self];
        //        self.locatePicker.frame= CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.3);
        //        [self.view addSubview:self.locatePicker];
        //
        //
        //        [UIView animateWithDuration:0.3 animations:^{
        //                    self.locatePicker.frame = CGRectMake(0, self.view.frame.size.height*0.7, self.view.frame.size.width, self.view.frame.size.height*0.3);
        //                }];
//        [self.locatePicker showInView:self.view];
        
//    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.areaText.frame =  CGRectMake(0, self.view.bounds.size.height*0.3, CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.1-20);
        self.okBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.8, self.view.bounds.size.height*0.3, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20);
        self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.3, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
        
       
    }];
    
//      int onlyMaHight=self.view.bounds.size.height*0.3;
    
    return NO;
}


#pragma mark - Utility

- (void)gotoDetailForGeocode:(AMapGeocode *)geocode
{
    if (geocode != nil)
    {
        GeoDetailViewController *geoDetailViewController = [[GeoDetailViewController alloc] init];
        geoDetailViewController.geocode = geocode;
        
        [self.navigationController pushViewController:geoDetailViewController animated:YES];
    }
}

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[GeocodeAnnotation class]])
    {
        [self gotoDetailForGeocode:[(GeocodeAnnotation*)view.annotation geocode]];
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[GeocodeAnnotation class]])
    {
        static NSString *geoCellIdentifier = @"geoCellIdentifier";
        
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:geoCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:geoCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}


#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
    }
    else
    {
        [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:annotations]
                               animated:YES];
    }
    
    [self.mapView addAnnotations:annotations];
}

#pragma mark - HandleAction

//- (void)tapAction
//{
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.address = self.tapButton.titleLabel.text;
//
//    [self.search AMapGeocodeSearch:geo];
//}

#pragma mark - 建立搜索框

- (void)setTextF1
{
 
       self.areaText = [[UITextField alloc] init];
    self.areaText.frame = CGRectMake(0, self.view.bounds.size.height*0.8, CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.1-20);
    
 
    self.areaText.backgroundColor = [UIColor whiteColor];
    self.areaText.text=self.areaButText;
 
    
    self.okBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*0.8, self.view.bounds.size.height*0.8, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20)];
    self.okBtn.titleLabel.textColor=[UIColor grayColor];
    
    [self.okBtn setTitle:@"🔍搜索" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.okBtn addTarget:self action:@selector(PinjieStr:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.areaText];
    [self.view addSubview:self.okBtn];
    
    
    self.adressMassage = [[UITextField alloc] init];
    self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.8, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
    self.adressMassage.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.adressMassage];
    
    
}
#pragma mark - 搜索按钮事件
-(void)PinjieStr:(id)sender{
    
    self.geo.address = [NSString stringWithFormat:@"%@ %@ ",self.areaStr,self.adressMassage.text];
    //区域拼接完毕然后传给定义好的areaStr先装好，等待继续拼接
//    self.areaStr=[NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    
    [self.search AMapGeocodeSearch:_geo];
    
}


#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 30)];
    activityBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    activityBtn.titleLabel.textColor=[UIColor whiteColor];
    [activityBtn setTitle:@"附近" forState:UIControlStateNormal];
    [activityBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 52, 11, 0);
    [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activityBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityBtn];
    
    
    

    self.edgesForExtendedLayout = UIRectEdgeNone;
     self.geo = [[AMapGeocodeSearchRequest alloc] init];
    [self setTextF1];
    self.areaText.delegate=self;
//    self.geo = [[AMapGeocodeSearchRequest alloc] init];
}

#pragma mark 导航栏按钮 右边的
-(void)btnPressed:(id)sender{
    //    FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
    //    [UIView animateWithDuration:0.2 animations:^{
    //
    //    } completion:^(BOOL finished) {
    //        [menu menuTapped];
    //    }];
//    FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
//    [UIView animateWithDuration:0.2 animations:^{
//        
//    } completion:^(BOOL finished) {
//        [menu menuTapped];
//    }];
    
//    ViewController *vc=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//    NSLog(@"dianji");
//    [self cancelLocatePicker];
//    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict
//                                                   withDelegate:self
//                                                  andDatasource:self];
//    [self.locatePicker showInView:self.view];
}


























@end
