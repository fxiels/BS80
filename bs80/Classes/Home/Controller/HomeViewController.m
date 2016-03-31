//
//  HomeViewController.m
//  bs80
//
//  Created by xie on 16/3/29.
//  Copyright © 2016年 bs80. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define GlobalBg RGBColor(100, 223, 223)

@interface HomeViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate>
// 中央管理者
@property(nonatomic,strong)CBCentralManager *mgr;
@property(nonatomic,strong)NSMutableArray *peripherals;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSOperationQueue *opQueue;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GlobalBg;
    
    UITextField *textField1;
    textField1 = [[UITextField alloc] initWithFrame:CGRectMake (10, 80 , self.view.frame.size.width-20, 30)];
    // textField.frame=CGRectMake(60, 70 , 200, 30);
    [textField1 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textField1];

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(self.view.frame.size.width/2-50, 88, 100, 100);
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-300) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}

// serviceUUIDs:可以将你想要扫描的服务的外围设备传入(传nil,扫描所有的外围设备)
-(void)click
{
    NSBlockOperation *download=[NSBlockOperation blockOperationWithBlock:^{
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
    }];
    [self.opQueue addOperation:download];
}

#pragma mark - CBCentralManager的代理方法
/**
 *  状态发生改变的时候会执行该方法(蓝牙4.0没有打开变成打开状态就会调用该方法)
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"--蓝牙4.0打开状态");
}

/**
 *  当发现外围设备的时候会调用该方法
 *  @param peripheral        发现的外围设备
 *  @param advertisementData 外围设备发出信号
 *  @param RSSI              信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (![self.peripherals containsObject:peripheral]) {
        [self.peripherals addObject:peripheral];
    }
    NSLog(@"发现外围设备--\n--%@--\n--%@--\n--%@-",peripheral,advertisementData,RSSI);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
    }];
}

/**
 *  连接上外围设备的时候会调用该方法
 *
 *  @param peripheral 连接上的外围设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // serviceUUIDs:指定要扫描该外围设备的哪些服务(传nil,扫描所有的服务)
    [peripheral discoverServices:nil];
    // 2.设置代理
    peripheral.delegate = self;
    NSLog(@"--连接上外围设备");
}

#pragma mark - CBPeripheral的代理方法
/**
 *  发现外围设备的服务会来到该方法(扫描到服务之后直接添加peripheral的services)
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *serivce in peripheral.services) {
    NSLog(@"--5555555-%@",serivce.UUID.UUIDString);
    if ([serivce.UUID.UUIDString isEqualToString:@"FFF0"]) {
        // characteristicUUIDs : 可以指定想要扫描的特征(传nil,扫描所有的特征)
        [peripheral discoverCharacteristics:nil forService:serivce];
        }
    }
    NSLog(@"--发现外围设备的服务");
}

/**
 *  当扫描到某一个服务的特征的时候会调用该方法
 *
 *  @param service    在哪一个服务里面的特征
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"-2222--%@",characteristic.UUID.UUIDString);
        NSLog(@"---外围交互的特征--%@---%@---%@",peripheral,service,error);
        NSString *valueStr=[[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        NSLog(@"---特征---%@",valueStr);
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}

- (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type
{
    
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"--发信息反馈-%@---%@---%@",peripheral,characteristic,error);
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"--发信息反馈-%@---%@---%@",peripheral,descriptor,error);
    
}
-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error{
    
}
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{
    
}

-(void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices
{
    
}
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}
-(void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    
}


-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // NSLog(@"---当扫描到某一个服务的特征的时候会调用该方法外围交互的特征--%@---%@---%@",peripheral,characteristic,error);
    
    NSLog(@"收到数据%@-\n---%@-\n--",[self hexadecimalString:characteristic.value],characteristic.value);
}







//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}






//将传入的NSString类型转换成NSData并返回
- (NSData*)dataWithHexstring:(NSString *)hexstring{
    NSData* aData;
    return aData = [hexstring dataUsingEncoding: NSASCIIStringEncoding];
}







#pragma mark - 连接设备
- (void)connect:(CBPeripheral *)peripheral
{
    // 连接外围设备
    [self.mgr connectPeripheral:peripheral options:nil];
    
    NSLog(@"--连接设备");
}



-(NSOperationQueue *)opQueue
{
    if (_opQueue==nil) {
        _opQueue=[[NSOperationQueue alloc] init];
        
    }
    return _opQueue;
}





#pragma mark - 懒加载代码
- (CBCentralManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _mgr;
}

- (NSMutableArray *)peripherals
{
    if (_peripherals == nil) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}







#pragma mark - tableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peripherals.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"CELLID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@", self.peripherals[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *peri=   self.peripherals[indexPath.row];
    [self connect:peri];
}




@end
