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
#define SH [UIScreen mainScreen].bounds.size.height
#define SW [UIScreen mainScreen].bounds.size.width
@interface GeoViewController() <UITextFieldDelegate,HZAreaPickerDelegate,HZAreaPickerDatasource>

@property (nonatomic, strong) UIButton *tapButton;
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (nonatomic,strong)  UITextField *areaText;
@property (nonatomic,retain) AMapGeocodeSearchRequest *geo;
@property (nonatomic,retain) UIButton *okBtn;
@property(nonatomic,retain) UITextField *adressMassage;
@property(nonatomic,retain) UILabel *coorLabel1;
@property(nonatomic,retain) UISlider *zoomSilder1;
@property(assign, readwrite, nonatomic) CGFloat latitude1;
@property(assign, readwrite, nonatomic) CGFloat longitude1;
@property(nonatomic,retain)MAPointAnnotation *pointAnnotation;
//@property(nonatomic,assign)

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



//-(void)cancelLocatePicker
//{
//    [self.locatePicker cancelPicker];
//    self.locatePicker.delegate = nil;
//    self.locatePicker = nil;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.areaText.frame = CGRectMake(0, self.view.bounds.size.height*0.8+50, CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.1-20);
//        self.okBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.8-3, self.view.bounds.size.height*0.8+50, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20);
//        self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.8+50, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
//    }];
//
//    
//    
//}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    [self cancelLocatePicker];
}

#pragma mark - TextField delegate Text 被点击
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
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.areaText.frame =  CGRectMake(0, self.view.bounds.size.height*0.3, CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.1-20);
//        self.okBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.8, self.view.bounds.size.height*0.3, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20);
//        self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.3, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
//        
//       
//    }];
    
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

//- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
//{
//    if ([view.annotation isKindOfClass:[GeocodeAnnotation class]])
//    {
//        [self gotoDetailForGeocode:[(GeocodeAnnotation*)view.annotation geocode]];
//    }
//}


#pragma mark -  地图被拖动后 调用
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    // 获取地图中心坐标
//            NSLog(@"地图中心坐标%f %f",mapView.region.center);
//    self.latitude1=geocodeAnnotation.coordinate.latitude;
//    self.longitude1=geocodeAnnotation.coordinate.longitude;
    //        NSString *latStr=[NSString stringWithFormat:@"%f %f",self.latitude1,self.longitude1];
      NSString *ZuoBiaoStr=[NSString stringWithFormat:@"经： %f          纬：%f",mapView.region.center];
      self.coorLabel1.text=ZuoBiaoStr;
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(mapView.region.center.latitude, mapView.region.center.longitude);
//    self.pointAnnotation.title = @"方恒国际";
//    self.pointAnnotation.subtitle = @"阜通东大街6号";
//    
//    [self.mapView addAnnotation:self.pointAnnotation];
   
 }
#pragma mark - MAMapViewDelegate 图钉属性
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[GeocodeAnnotation class]])
//    {
//        static NSString *geoCellIdentifier = @"geoCellIdentifier";
//        
//        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:geoCellIdentifier];
//        if (poiAnnotationView == nil)
//        {
//            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:geoCellIdentifier];
//        }
//
//        poiAnnotationView.canShowCallout = YES;
//        poiAnnotationView.setDragState=
//        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        
//        return poiAnnotationView;
//    }
//    
//    return nil;
//}
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        
//        return annotationView;
//    }
//    return nil;
//}


#pragma mark - AMapSearchDelegate  获取图钉坐标

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        self.latitude1=geocodeAnnotation.coordinate.latitude;
        self.longitude1=geocodeAnnotation.coordinate.longitude;
//        NSString *latStr=[NSString stringWithFormat:@"%f %f",self.latitude1,self.longitude1];
        
        NSString *ZuoBiaoStr=[NSString stringWithFormat:@"经： %f          纬：%f",self.longitude1,self.latitude1];
        self.coorLabel1.text=ZuoBiaoStr;
        
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
    [self.mapView removeAnnotations:annotations];
}

#pragma mark - HandleAction

//- (void)tapAction
//{
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.address = self.tapButton.titleLabel.text;
//
//    [self.search AMapGeocodeSearch:geo];
//}

#pragma mark - 创建各种UI控件

- (void)setTextF1
{
    //显示区域
       self.areaText = [[UITextField alloc] init];
    self.areaText.frame = CGRectMake(0, self.view.bounds.size.height*0.8, CGRectGetWidth(self.view.bounds)*0.3, self.view.bounds.size.height*0.1-20);
    
 
    self.areaText.backgroundColor = [UIColor whiteColor];
    self.areaText.text=self.areaButText;
     [self.view addSubview:self.areaText];
 
    //搜索按钮
    self.okBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*0.8, self.view.bounds.size.height*0.8, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20)];
    self.okBtn.titleLabel.textColor=[UIColor grayColor];
    self.okBtn.backgroundColor=[UIColor whiteColor];
    
    [self.okBtn setTitle:@"🔍搜索" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.okBtn addTarget:self action:@selector(PinjieStr:) forControlEvents:UIControlEventTouchUpInside];
 
    [self.view addSubview:self.okBtn];
    
    
    self.adressMassage = [[UITextField alloc] init];
    self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.8, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
    self.adressMassage.placeholder=@" 请输入详细地址...";
    self.adressMassage.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.adressMassage];
    //创建一个slider
    self.zoomSilder1=[[UISlider alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.2, self.view.bounds.size.height*0.8+20, 250, 30)];
    self.zoomSilder1.maximumValue=18.0f;
    self.zoomSilder1.minimumValue=0.0f;
    self.zoomSilder1.value=10;
    [self.zoomSilder1 addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:self.zoomSilder1];
    self.zoomSilder1.continuous = YES;
    //创建一个label显示坐标
    self.coorLabel1=[[UILabel alloc] initWithFrame:CGRectMake(0, SH*0.2, CGRectGetWidth(self.view.bounds), self.view.bounds.size.height*0.09-30)];
    self.coorLabel1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.coorLabel1];
    // 创建一个图钉图片一直放在地图中心
    UIImage *image1=[UIImage imageNamed:@"TuDing123"];
    UIImageView *centerIma=[[UIImageView alloc] initWithImage:image1];
    centerIma.frame = CGRectMake(SW/2-8, SH/2-29, 30, 30);
//        centerView1.backgroundColor=[UIColor redColor];
    [self.onlyMapView addSubview:centerIma];
    
    
    
    
    
    //创建一个pickerView
 
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict
                                                   withDelegate:self
                                                  andDatasource:self];
    [self.locatePicker showInView:self.view];
   
    
    [UIView animateWithDuration:0.3 animations:^{
        self.areaText.frame =  CGRectMake(0, SH*0.2+self.view.bounds.size.height*0.09-30, CGRectGetWidth(self.view.bounds)*0.4, self.view.bounds.size.height*0.1-20);
        self.okBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.8-3, SH*0.2+self.view.bounds.size.height*0.09-30, CGRectGetWidth(self.view.bounds)*0.8*0.3,self.view.bounds.size.height*0.1-20);
        self.adressMassage.frame = CGRectMake(CGRectGetWidth(self.view.bounds)*0.4,SH*0.2+self.view.bounds.size.height*0.09-30, CGRectGetWidth(self.view.bounds)*0.4-3, self.view.bounds.size.height*0.1-20);
    }];
    
}
#pragma mark -  按钮事件
-(void)PinjieStr:(id)sender{
    
    self.geo.address = [NSString stringWithFormat:@"%@ %@ ",self.areaStr,self.adressMassage.text];
    //区域拼接完毕然后传给定义好的areaStr先装好，等待继续拼接
//    self.areaStr=[NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    
    [self.search AMapGeocodeSearch:_geo];
    
}
-(void)sliderChanged{
    self.mapView.zoomLevel=self.zoomSilder1.value;
}


#pragma mark   viewDidLoad

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
    self.geo.address =@"广州";
    [self.search AMapGeocodeSearch:_geo];
    [self setTextF1];
    self.areaText.delegate=self;
    
    
//    self.pointAnnotation = [[MAPointAnnotation alloc] init];
    
    
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
