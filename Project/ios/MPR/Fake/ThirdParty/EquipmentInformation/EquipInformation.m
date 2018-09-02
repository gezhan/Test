//
//  EquipInformation.m
//  zcmjr
//
//  Created by nil on 2017/8/5.
//  Copyright © 2017年 Facebook. All rights reserved.
//


//
//  ViewController.m
//  Test_DeviceInfo
//
//  Created by HWC on 2017/7/21.
//  Copyright © 2017年 HWC. All rights reserved.
//

#import "EquipInformation.h"
//获取网络类型跟运营商信息
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreLocation/CoreLocation.h>
//设备的硬盘总容量
#include <sys/param.h>
#include <sys/mount.h>
//获取ip地址
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>
#include <sys/socket.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

//获取广告表示
#import <AdSupport/AdSupport.h>

//获取cpu
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>
#import <sys/types.h>
#include <sys/sysctl.h>
#include <sys/stat.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <sys/utsname.h>

#import "Reachability.h"



@interface EquipInformation ()<CLLocationManagerDelegate>
@property(nonatomic, strong) CLLocation * currentLocation;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) NSString *latitudeLocation;//经度
@property(nonatomic, strong) NSString *longitudeLocation;//纬度
@property(nonatomic, strong) NSString *dwSwitch;//定位开关
@property(nonatomic, strong) NSString *dwSQ;//定位授权状态
@end

@implementation EquipInformation


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
 
  
  
  
}

//-(void)inits{
//  //获取当前经纬度
//  _locationManager = [[CLLocationManager alloc]init];
//  [_locationManager requestWhenInUseAuthorization];
//  _locationManager.delegate = self;
//  [_locationManager startUpdatingLocation];
//}

-(NSMutableDictionary *)setDeviceIformation{
  
  NSMutableDictionary *dic = [NSMutableDictionary dictionary];
  //获取IDFA

    [dic setValue:[NSString stringWithFormat:@"%@",[self getIDFA]] forKey:@"idfa"];

  //获取IDFV

    [dic setValue:[NSString stringWithFormat:@"%@",[self getIDFV]] forKey:@"idfv"];

  //获取设备UUID

    [dic setValue:[NSString stringWithFormat:@"%@",[self getUUID]] forKey:@"uuid"];
  
  //获取手机开机时间
    [dic setValue:[NSString stringWithFormat:@"%@",[self bootTime]] forKey:@"bootTime"];

  //获取手机当前时间
    [dic setValue:[NSString stringWithFormat:@"%@",[self getDeviceCurrenTime]] forKey:@"currentTime"];
  
  //获取手机运行了多长时间
    [dic setValue:[NSString stringWithFormat:@"%@",[self getDeviceRunTime]] forKey:@"upTime"];
  
  //获取硬盘总容量
    [dic setValue:[NSString stringWithFormat:@"%@",[self getTotalDiskSize]] forKey:@"totalSpace"];
  
  //获取硬盘可用容量
    [dic setValue:[NSString stringWithFormat:@"%@",[self getAvailableDiskSize]] forKey:@"freeSpace"];

  //手机内存总量
    [dic setValue:[NSString stringWithFormat:@"%@",[self totalMemoryBytes]] forKey:@"memory"];
  
  //手机占用内存
//  if ([self freeMemoryBytes]) {
//    [dic setValue:[self freeMemoryBytes] forKey:@"freeMemoryBytes"];
//  }
  
  //获取手机屏幕亮度
    [dic setValue:[NSString stringWithFormat:@"%@",[self getDeviceScreenBrightness]] forKey:@"brightness"];

  //获取手机充电状态
    [dic setValue:[NSString stringWithFormat:@"%@",[self getDeviceChargingStatus]] forKey:@"batteryStatus"];
  
  //电池电量
    [dic setValue:[NSString stringWithFormat:@"%@",[self setBatterylevel]] forKey:@"batteryLevel"];

  //获取ip地址
    [dic setValue:[NSString stringWithFormat:@"%@",[self getIPAddress:YES]] forKey:@"cellIp"];
  
  //获取wifi Ip
    [dic setValue:[NSString stringWithFormat:@"%@",[self getIPAddress]] forKey:@"wifiIp"];
  
  //Wifi掩码
    [dic setValue:[NSString stringWithFormat:@"%@",[self getWifiNetMask]] forKey:@"wifiNetmask"];

  
  //VPN
  
  //VPN掩码
  
  //mac地址
  [dic setValue:@"" forKey:@"mac"];
  
  //获取联网方式
    [dic setValue:[NSString stringWithFormat:@"%@",[self networkType]] forKey:@"networkType"];

  
  //无线网络
    [dic setValue:[NSString stringWithFormat:@"%@",[self getSSID]] forKey:@"ssid"];

  //无线BSSID
    [dic setValue:[NSString stringWithFormat:@"%@",[self getBSSID]] forKey:@"bssid"];

  
  //代理类型
  
  //代理地址
    [dic setValue:[NSString stringWithFormat:@"%@",[self getProxyInfo]] forKey:@"proxyUrl"];
  
  //DNS
  
  //获取设备是否越狱
    [dic setValue:[NSString stringWithFormat:@"%@",[self isJailbreak]] forKey:@"jailbreak"];
  
  //设备类型
    [dic setValue:[NSString stringWithFormat:@"%@",[self getPlatform]] forKey:@"platform"];
    
  //手机系统版本
    [dic setValue:[NSString stringWithFormat:@"%@",[self setphoneVersion]] forKey:@"osVersion"];

  
  //设备名称
    [dic setValue:[NSString stringWithFormat:@"%@",[self getDeviceName]] forKey:@"deviceName"];

  
  //获取运营商信息
    [dic setValue:[NSString stringWithFormat:@"%@",[self getCarrierName]] forKey:@"carrier"];
  
  //获取mcc mnc
    [dic setValue:[NSString stringWithFormat:@"%@",[self getMMCAndMNC:@"mcc"]] forKey:@"mcc"];

    [dic setValue:[NSString stringWithFormat:@"%@",[self getMMCAndMNC:@"mnc"]] forKey:@"mnc"];

  //国家代码
    [dic setValue:[NSString stringWithFormat:@"%@",[self getCountryCode]] forKey:@"countryIso"];
  
  //设备语言编码
    [dic setValue:[NSString stringWithFormat:@"%@",[self phoneCodinglanguage]] forKey:@"languages"];

  
  //获取boundleID
    [dic setValue:[NSString stringWithFormat:@"%@",[self getBundleID]] forKey:@"bundleId"];

  //app版本号
    [dic setValue:[NSString stringWithFormat:@"%@",[self appVersion]] forKey:@"appVersion"];
  
  //获取时区
    [dic setValue:[NSString stringWithFormat:@"%@",[self getTimeZone]] forKey:@"timeZone"];
  
  //获取内核版本
    [dic setValue:[NSString stringWithFormat:@"%@",[self getkernelVersion]] forKey:@"kernelVersion"];

  //获取真实IP
    [dic setValue:[NSString stringWithFormat:@""] forKey:@"trueIp"];
//    [dic setValue:[self getTrueIP] forKey:@"trueIp"];
  
  // CPU总数目
    [dic setValue:[NSString stringWithFormat:@"%@",[self getCPUCount]] forKey:@"CPUCount"];
  
  // 获取每个cpu的使用比例
    [dic setValue:[NSString stringWithFormat:@"%@",[self getPerCPUUsage]] forKey:@"PerCPUUsage"];
  
  // 已使用的CPU比例
    [dic setValue:[NSString stringWithFormat:@"%@",[self getCPUUsage]] forKey:@"CPUUsage"];

  //手机系统 
    [dic setValue:[NSString stringWithFormat:@"%@",[self setiponeM]] forKey:@"tiponeM"];
  
  //分辨率
    [dic setValue:[NSString stringWithFormat:@"%@",[self resolution]] forKey:@"resolution"];

//  获取时间
    [dic setValue:[NSString stringWithFormat:@"%@",[self setDate]] forKey:@"Date"];
  
  //获取定位开关是否开启
    [dic setValue:[NSString stringWithFormat:@"%@",[self getGPSSwitch]] forKey:@"gpsSwitch"];

  //获取定位授权状态
    [dic setValue:[NSString stringWithFormat:@"%@",[self getGPSAuth]] forKey:@"gpsAuthStatus"];
  
  return dic;
}

//获取联网方式
-(NSString *)networkType{
	
	Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
	NetworkStatus internetStatus = [reachability currentReachabilityStatus];
	NSString *net = @"";
	switch (internetStatus) {
		case ReachableViaWiFi:
			net = @"WIFI";
			break;
			
		case ReachableViaWWAN:
			net = @"蜂窝数据";
			net = [self getNetType ];   //判断具体类型
			break;
			
		case NotReachable:
			net = @"当前无网络连接";
			
		default:
			break;
	}
  NSLog(@"网络类型：%@",net);
  return net;
}
- (NSString *)getNetType{
	NSString *netconnType = @"";
	CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
	NSString *currentStatus = info.currentRadioAccessTechnology;
	if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
		netconnType = @"2G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
		netconnType = @"2G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
		netconnType = @"3G";
	}else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
		netconnType = @"4G";
	}
	return netconnType;
}

#pragma mark - 获取设备当前网络IP地址
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
  NSArray *searchArray = preferIPv4 ?
  @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
  @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
  
  NSDictionary *addresses = [self getIPAddresses];
  NSLog(@"addresses: %@", addresses);
  
  __block NSString *address;
  [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
   {
     address = addresses[key];
     //筛选出IP地址格式
     if([self isValidatIP:address]) *stop = YES;
   } ];
  NSLog(@"手机ip地址:%@",address);
  return address ? address : @"0.0.0.0";
}
- (BOOL)isValidatIP:(NSString *)ipAddress {
  if (ipAddress.length == 0) {
    return NO;
  }
  NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
  "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
  "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
  "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
  
  NSError *error;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
  
  if (regex != nil) {
    NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
    
    if (firstMatch) {
      NSRange resultRange = [firstMatch rangeAtIndex:0];
      NSString *result=[ipAddress substringWithRange:resultRange];
      //输出结果
      NSLog(@"%@",result);
      return YES;
    }
  }
  return NO;
}
- (NSDictionary *)getIPAddresses
{
  NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
  
  // retrieve the current interfaces - returns 0 on success
  struct ifaddrs *interfaces;
  if(!getifaddrs(&interfaces)) {
    // Loop through linked list of interfaces
    struct ifaddrs *interface;
    for(interface=interfaces; interface; interface=interface->ifa_next) {
      if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
        continue; // deeply nested code harder to read
      }
      const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
      char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
      if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
        NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
        NSString *type;
        if(addr->sin_family == AF_INET) {
          if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
            type = IP_ADDR_IPv4;
          }
        } else {
          const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
          if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
            type = IP_ADDR_IPv6;
          }
        }
        if(type) {
          NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
          addresses[key] = [NSString stringWithUTF8String:addrBuf];
        }
      }
    }
    // Free memory
    freeifaddrs(interfaces);
  }
  return [addresses count] ? addresses : nil;
}
//获取wifi 子网掩码
- (NSString *)getWifiNetMask {
  
  NSString * netMask = @"";
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  int success = 0;
  
  // retrieve the current interfaces - returns 0 on success
  success = getifaddrs(&interfaces);
  if (success == 0) {
    // Loop through linked list of interfaces
    temp_addr = interfaces;
    //*/
    while(temp_addr != NULL) {
      if(temp_addr->ifa_addr->sa_family == AF_INET) {
        // Check if interface is en0 which is the wifi connection on the iPhone
        if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
          //----192.168.1.255 广播地址
          NSString *broadcast = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
          
          //                    NSLog(@"broadcast address--%@",broadcast);
          //--192.168.1.106 本机地址
          NSString *localIp = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
          
          //                    NSLog(@"local device ip--%@",localIp);
          //--255.255.255.0 子网掩码地址
          NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
          if (netmask) {
            netMask = netmask;
          }
          NSLog(@"Wifi掩码:%@",netmask);
          //--en0 端口地址
          NSString *interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
          //                    NSLog(@"interface--%@",interface);
          return netMask;
        }
      }
      
      temp_addr = temp_addr->ifa_next;
    }
  }
  
  // Free memory
  freeifaddrs(interfaces);
  return netMask;
}

- (NSString *)getProxyInfo{
  //得到代理
  CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
  NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
  
  
  //是否开启了http代理
  if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
    
    NSString *proxyAddress = [dictProxy objectForKey:@"HTTPProxy"]; //代理地址
    NSInteger proxyPort = [[dictProxy objectForKey:@"HTTPPort"] integerValue];  //代理端口号
    NSLog(@"代理地址:%@",proxyAddress);
    return proxyAddress;
    
  }
  return @"";
}

//获取运营商信息
-(NSString *)getCarrierName{
  CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
  NSString *currentCountry = [carrier carrierName];
  NSLog(@"运营商信息：%@",currentCountry);
  return currentCountry;
}
//获取硬盘总容量
-(NSString *)getTotalDiskSize{
  struct statfs buf;
  unsigned long long freeSpace = -1;
  if (statfs("/var", &buf) >= 0)
  {
    freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
  }
  NSString *free = [NSString stringWithFormat:@"%llu",freeSpace];
  NSLog(@"硬盘总容量：%llu",freeSpace);
  return free;
}
//获取硬盘可用容量
-(NSString *)getAvailableDiskSize{
  struct statfs buf;
  unsigned long long freeSpace = -1;
  if (statfs("/var", &buf) >= 0)
  {
    freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
  }
  NSString *free = [NSString stringWithFormat:@"%llu",freeSpace];
  NSLog(@"硬盘可用容量：%llu",freeSpace);
  return free;
}
//获取设备序列号UUID
-(NSString *)getUUID{
  NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
  NSLog(@"手机UUID: %@",identifierNumber);
  return identifierNumber;
}
//获取设备是否越狱
-(NSString *)isJailbreak{
  //由于iOS9以后出现白名单，造成控制台不断打印警告
  //所以换成以下方式判断
  NSArray *paths = @[@"/Applications/Cydia.app",
                     @"/private/var/lib/apt/",
                     @"/private/var/lib/cydia",
                     @"/private/var/stash"];
  for (NSString *path in paths) {
    NSString *str = [NSString stringWithFormat:@"YES"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return str;
  }
  
  FILE *bash = fopen("/bin/bash", "r");
  if (bash != NULL) {
    fclose(bash);
    NSString *str = [NSString stringWithFormat:@"YES"];
    return str;
  }
  
  NSString *path = [NSString stringWithFormat:@"/private/%@", [self stringWithUUID]];
  if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    NSLog(@"手机是否越狱: %@",@"YES");
    NSString *str = [NSString stringWithFormat:@"YES"];
    return str;
  }
  NSLog(@"手机是否越狱: %@",@"NO");
  NSString *str = [NSString stringWithFormat:@"NO"];
  return str;
}
-(NSString *)stringWithUUID {
  CFUUIDRef uuid = CFUUIDCreate(NULL);
  CFStringRef string = CFUUIDCreateString(NULL, uuid);
  CFRelease(uuid);
  return (__bridge_transfer NSString *)string;
}


//获取ip地址
- (NSString *)getIPAddress
{
  NSString * address = @"error";
  struct ifaddrs * interfaces = NULL;
  struct ifaddrs * temp_addr = NULL;
  int success = 0;
  //检索当前接口 - 成功返回0
  success = getifaddrs(&interfaces);
  if(success == 0){
    //循环链接的接口列表
    temp_addr = interfaces;
    while(temp_addr != NULL){
      if(temp_addr-> ifa_addr-> sa_family == AF_INET){
        //检查接口是否是en0，这是iPhone上的WiFi连接
        if([[NSString stringWithUTF8String:temp_addr -> ifa_name] isEqualToString:@"en0"]){
          //从C字符串获取NSString
          address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr -> ifa_addr) -> sin_addr)];
          NSLog(@"wifi打开时手机ip地址: %@",address);
          return address;
        }
      }
      temp_addr = temp_addr -> ifa_next;
    }
  }
  return address;
}
#pragma mark 获取WiFi SSID信息
- (NSDictionary *)getWIFIDic{
  CFArrayRef myArray = CNCopySupportedInterfaces();
  if (myArray != nil) {
    CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
    if (myDict != nil) {
      NSDictionary *dic = (NSDictionary*)CFBridgingRelease(myDict);
      return dic;
    }
  }
  return nil;
}
#pragma mark 获取WIFI下的BSSID
- (NSString *)getBSSID{
  NSDictionary *dic = [self getWIFIDic];
  if (dic == nil) {
    return nil;
  }
  NSLog(@"BSSID：%@",dic[@"BSSID"]);
  return dic[@"BSSID"];
}
#pragma mark 获取WIFI下的SSID
- (NSString *)getSSID{
  NSDictionary *dic = [self getWIFIDic];
  if (dic == nil) {
    return nil;
  }
  NSLog(@"SSID：%@",dic[@"SSID"]);
  return dic[@"SSID"];
}
// CPU总数目
- (NSString *)getCPUCount {
  NSLog(@"CPU总数目: %ld",(long)[NSProcessInfo processInfo].activeProcessorCount);
  NSString *str = [NSString stringWithFormat:@"%ld",(long)[NSProcessInfo processInfo].activeProcessorCount];
  return str;
}
// 已使用的CPU比例
- (NSString *)getCPUUsage {
  float cpu = 0;
  NSArray *cpus = [self getPerCPUUsage];
  if (cpus.count == 0) return @"-1";
  for (NSNumber *n in cpus) {
    cpu += n.floatValue;
  }
  NSLog(@"已使用的CPU比例: %.4f",cpu);
  NSString *str = [NSString stringWithFormat:@"%.4f",cpu];
  return str;
}
// 获取每个cpu的使用比例
- (NSArray *)getPerCPUUsage {
  processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
  mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
  unsigned _numCPUs;
  NSLock *_cpuUsageLock;
  
  int _mib[2U] = { CTL_HW, HW_NCPU };
  size_t _sizeOfNumCPUs = sizeof(_numCPUs);
  int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
  if (_status)
    _numCPUs = 1;
  
  _cpuUsageLock = [[NSLock alloc] init];
  
  natural_t _numCPUsU = 0U;
  kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
  if (err == KERN_SUCCESS) {
    [_cpuUsageLock lock];
    
    NSMutableArray *cpus = [NSMutableArray new];
    for (unsigned i = 0U; i < _numCPUs; ++i) {
      Float32 _inUse, _total;
      if (_prevCPUInfo) {
        _inUse = (
                  (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                  + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                  + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                  );
        _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
      } else {
        _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
        _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
      }
      [cpus addObject:@(_inUse / _total)];
    }
    
    [_cpuUsageLock unlock];
    if (_prevCPUInfo) {
      size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
      vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
    }
    NSLog(@"获取每个cpu的使用比例: %@",cpus);
    return cpus;
  } else {
    return nil;
  }
}

//---------
//设备语言编码
-(NSString *)phoneCodinglanguage{
  NSString *udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
  NSLog(@"设备语言编码-国家代码+语言: %@",udfLanguageCode);
  return udfLanguageCode;
}
//获取时间
-(NSString *)setDate{
  NSDate  *currentDate = [NSDate date];
  NSLog(@"获取时间 : 时间 = %@ ",currentDate);
  return [NSString stringWithFormat:@"%@",currentDate];
}

//获取IDFA
-(NSString *)getIDFA{
  NSString
  *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  NSLog(@"获取IDFA : %@",idfa);
  return idfa;
}

//获取IDFV
-(NSString *)getIDFV{
  NSString
  *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
  NSLog(@"获取IDFV : %@",idfv);
  return idfv;
}
//获取开机时间
- (NSString *)bootTime{
  NSTimeInterval timer_ = [NSProcessInfo processInfo].systemUptime;
  NSDate *currentDate = [NSDate new];
  NSDate *startTime = [currentDate dateByAddingTimeInterval:(-timer_)];
  NSTimeInterval convertStartTimeToSecond = [startTime timeIntervalSince1970];
  NSString *str = [NSString stringWithFormat:@"%.f",convertStartTimeToSecond];
  NSLog(@"获取获取开机时间 : %@",str);
  return str;
}

//当前时间
- (NSString *)getDeviceCurrenTime{
  NSDate *currentDate = [NSDate new];
  NSTimeInterval currentTime = [currentDate timeIntervalSince1970];
  NSString *str = [NSString stringWithFormat:@"%.f",currentTime];
  NSLog(@"获取设备当前时间 : %@",str);
  return str;
}

//运行时间
- (NSString *)getDeviceRunTime{
  NSTimeInterval runTime = [NSProcessInfo processInfo].systemUptime;
  NSString *str = [NSString stringWithFormat:@"%.f",runTime];
  NSLog(@"获取设备已运行的时间 : %@",str);
  return str;
}
//获取屏幕亮度
- (NSString *)getDeviceScreenBrightness{
  CGFloat num = [UIScreen mainScreen].brightness;
  NSString *brightness = [NSString stringWithFormat:@"%d%@",(int)(num*100),@"%"] ;
  NSLog(@"获取设备屏幕亮度 : %@",brightness);
  return brightness;
}
//获取当前设备充电状态
- (NSString *)getDeviceChargingStatus{
  //打开电池的监听
  [UIDevice currentDevice].batteryMonitoringEnabled = YES;
  //获取电池的状态
  UIDeviceBatteryState BatteryState = [UIDevice currentDevice].batteryState;
  NSString *state = @"未知";
  switch (BatteryState) {
    case UIDeviceBatteryStateUnknown:
      state = @"未知";
      break;
    case UIDeviceBatteryStateUnplugged:
      state = @"未充电";
      break;
    case UIDeviceBatteryStateCharging:
      state = @"charging";
      break;
    case UIDeviceBatteryStateFull:
      state = @"满电";
      break;
    default:
      break;
  }
  NSLog(@"获取设备充电状态 : %@",state);
  return state;
}
//手机系统版本
-(NSString *)setphoneVersion{
  NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];;
  NSLog(@"手机系统版本 : %@",phoneVersion);
  return phoneVersion;
}
//设备类型
-(NSString *)getPlatform{
  size_t size;
  
  sysctlbyname("hw.machine", NULL, &size, NULL, 0);
  
  char *machine = (char*)malloc(size);
  
  sysctlbyname("hw.machine", machine, &size, NULL, 0);
  
  NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
  NSLog(@"设备类型 : %@",platform);
  return platform;
}
//设备名称
-(NSString *)getDeviceName{
  NSString* DeviceName = [[UIDevice currentDevice] name];;
  NSLog(@"设备名称 : %@",DeviceName);
  return DeviceName;
}

//手机系统
- (NSString *)setiponeM{
  NSString * iponeM = [[UIDevice currentDevice] systemName];
  NSLog(@"手机系统 : %@",iponeM);
  return iponeM;
}
//电池电量
- (NSString *)setBatterylevel{
  [UIDevice currentDevice].batteryMonitoringEnabled = YES;
  CGFloat batteryLevel=[UIDevice currentDevice].batteryLevel;
  NSLog(@"电池电量 : %d%@",(int)(batteryLevel*100) ,@"%");
  NSString *str = [NSString stringWithFormat:@"%d%@",(int)(batteryLevel*100) ,@"%"];
  return str;
}
//分辨率
- (NSString *)resolution
{
  CGRect bounds = [[UIScreen mainScreen] bounds];
  CGFloat scale = [[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.f;
  CGSize res = CGSizeMake(bounds.size.width * scale, bounds.size.height * scale);
  NSString *result = [NSString stringWithFormat:@"%gx%g", res.width, res.height];
  NSLog(@"分辨率 : %@",result);
  return result;
}

//app版本号
- (NSString *)appVersion{
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
  NSLog(@"app版本号 : %@",app_Version);
  return app_Version;
}


//获取国家代码
- (NSString *)getCountryCode{
  NSLocale *currentLocale = [NSLocale currentLocale];
  NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
  NSLog(@"国家代码:%@",countryCode);
  return countryCode;
}


- (void)getGeo:(NSDictionary *)dic{
  //    NSArray *keys = [dic allKeys];
  //    for (NSString *key in keys) {
  //        NSLog(@"%@:%@",key,dic[key]);
  //    }
  NSLog(@"geo地理位置信息:%@",dic);
}


- (NSUInteger)getSysInfo:(uint)typeSpecifier
{
  size_t size = sizeof(int);
  int results;
  int mib[2] = {CTL_HW, typeSpecifier};
  sysctl(mib, 2, &results, &size, NULL, 0);
  return (NSUInteger) results ;
}

//手机内存总量
- (NSString *)totalMemoryBytes
{
  NSString *total = [NSString stringWithFormat:@"%ld",(long)[self getSysInfo:HW_PHYSMEM]];
  NSLog(@"//手机内存: %ld ",(long)[self getSysInfo:HW_PHYSMEM]);
  return total;
}
//手机占用内存
- (NSString *)freeMemoryBytes
{
  mach_port_t           host_port = mach_host_self();
  mach_msg_type_number_t   host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
  vm_size_t               pagesize;
  vm_statistics_data_t     vm_stat;
  
  host_page_size(host_port, &pagesize);
  
  if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) NSLog(@"Failed to fetch vm statistics");
  
  //    natural_t   mem_used = (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize;
  natural_t   mem_free = vm_stat.free_count * pagesize;
  //    natural_t   mem_total = mem_used + mem_free;
  NSLog(@"手机占用内存: %u",mem_free);
  NSString *str = [NSString stringWithFormat:@"%u",mem_free];
  return str;
}
//获取boundId
-(NSString*) getBundleID

{
  NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
  NSLog(@"BundleID:%@",bundleID);
  return bundleID;
  
}

//获取时区
- (NSString *)getTimeZone{
  NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
  NSLog(@"系统时区%@",[NSString stringWithFormat:@"%ld",zone.secondsFromGMT]);
  return [NSString stringWithFormat:@"%ld",zone.secondsFromGMT];
}
//定位开关
- (NSString *)getGPSSwitch{
  BOOL flag = [CLLocationManager locationServicesEnabled];
  if(flag){
    NSLog(@"定位开关:OPEN");
    return @"OPEN";
  }
  else{
    NSLog(@"定位开关:CLOSE");
    return @"CLOSE";
  }
}
//获取定位权限状态
- (NSString *)getGPSAuth{
  CLAuthorizationStatus state = [CLLocationManager authorizationStatus];
  NSString *str = @"" ;
  switch (state) {
    case kCLAuthorizationStatusNotDetermined:
      str = @"kCLAuthorizationStatusNotDetermined";
      break;
    case kCLAuthorizationStatusRestricted:
      str = @"kCLAuthorizationStatusRestricted";
      break;
    case kCLAuthorizationStatusDenied:
      str = @"kCLAuthorizationStatusDenied";
      break;
    case kCLAuthorizationStatusAuthorizedAlways:
      str = @"kCLAuthorizationStatusAuthorizedAlways";
      break;
    case kCLAuthorizationStatusAuthorizedWhenInUse:
      str = @"kCLAuthorizationStatusAuthorizedWhenInUse";
      break;
    default:
      break;
  }
  NSLog(@"定位权限状态:%@",str);
  return str;
}
//获取mmc
- (NSString *)getMMCAndMNC:(NSString *)type{
  CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
  
  CTCarrier *carrier = [netInfo subscriberCellularProvider];
  
  NSString *mcc = [carrier mobileCountryCode];
  
  NSString *mnc = [carrier mobileNetworkCode];
  NSLog(@"mcc:%@",mcc);
  NSLog(@"mnc:%@",mnc);
  if ([type isEqualToString:@"mcc"]) {
    return mcc;
  }
    return mnc;

}
//获取内核版本
- (NSString *)getkernelVersion{
  struct utsname systeminfo;
  uname(&systeminfo);
  NSString *version = [NSString stringWithCString:systeminfo.version encoding:NSUTF8StringEncoding];
  
  NSLog(@"内核版本:%@",version);
  return version;
}
//获取真实IP地址
- (NSString *)getTrueIP{
  NSError *error;
  NSURL *ipURL = [NSURL URLWithString:@"http://ifconfig.me/ip"];
  NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
  NSLog(@"真实IP地址:%@",ip);
  return ip;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
