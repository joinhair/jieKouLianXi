//
//  ViewController.m
//  接口练习
//
//  Created by OS X  on 18/3/10.
//
//

#import "ViewController.h"
#import "NewModel.h"

@interface ViewController () <NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableData *_serverData;
}
@property (nonatomic, copy) NSString *name;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *modelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.userName = [[UITextField alloc] init];
    self.password = [[UITextField alloc] init];
    
    _userName.text = @"1";
    _password.text = @"1";
    
    //[self getRequest];
    [self postRequest];
    
    //[self syncGet];
    //[self syncPostt];
    
    //[self aSyncGet];
    //[self aSyncPost];
    
    if (_name == nil) {
        NSLog(@"%@",_name);
    }
    _serverData = [NSMutableData data];
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:@"str1"];
    [mutableStr appendString:@"str2"];
    NSLog(@"%@",mutableStr);
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"music90"]];
    imageView1.frame = CGRectMake(10, 150, 90, 90);
    imageView1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView1];
    [imageView1 removeFromSuperview];
    
    NSLog(@"我们出去玩\r好激动");
    
    const int *a;
    int b;
    a = &b;
    //*a = 8;
    b = 10;
    
    int d;
   int const *c;
    c = &b;
    c = &d;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - get请求
- (void)getRequest{
    NSString *urlStr = [NSString stringWithFormat:@"https://www.apiopen.top/satinApi?type=%@&page=%@",_userName.text,_password.text];
    //NSURL *url = [NSURL URLWithString:urlStr];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSHTTPURLResponse
    //建立连接
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //启动连接
    [connection start];

}

#pragma mark - post请求
- (void)postRequest{
    NSString *urlStr = [NSString stringWithFormat:@"https://www.apiopen.top/satinApi"];
    //NSURL *url = [NSURL URLWithString:urlStr];
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",url);
    
    //2.建立请求
    
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    //NSHTTPURLResponse
    [requestM setTimeoutInterval:8];
    [requestM setHTTPMethod:@"post"];
    NSString *dataBodyStr = [NSString stringWithFormat:@"type=%@&page=%@",_userName.text,_password.text];
    //将数据体字符串转化为data隐藏
    NSData *dataBodyData = [dataBodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [requestM setHTTPBody:dataBodyData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requestM delegate:self];
    [connection start];

}

#pragma mark - 同步get请求
- (void)syncGet{
    //1.确定网址(get)
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.apiopen.top/satinApi?type=%@&page=%@",_userName.text,_password.text]];
    //2.建立网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.发送同步请求
    NSData *reponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *reponseDataStr = [[NSString alloc]initWithData:reponseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",reponseDataStr);
}

#pragma mark - 同步post请求
- (void)syncPost{
    //1.确定网址(get)
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.apiopen.top/satinApi"]];
    //2.建立网络可变请求
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    //3.设置请求超时时间和http方法
    [requestM setTimeoutInterval:8];
    [requestM setHTTPMethod:@"post"];
    
    //4.包裹数据体
    NSString *dataBodyStr = [NSString stringWithFormat:@"type=%@&page=%@",_userName.text,_password.text];
    NSData *dataBodyData = [dataBodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //5.将二进制数据体附加在可变请求requestM上
    [requestM setHTTPBody:dataBodyData];
    
    //6.发送同步请求
    NSData *reponseData = [NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:nil];
    NSString *reponseDataStr = [[NSString alloc]initWithData:reponseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",reponseDataStr);

}

#pragma mark - 异步get请求
- (void)aSyncGet{
    //1.确定网址(get)
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.apiopen.top/satinApi?type=%@&page=%@",_userName.text,_password.text]];
    //2.建立网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSString *reponseDataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",reponseDataStr);
    }];

}

#pragma mark - 异步post请求
- (void)aSyncPost{
    //1.确定网址(get)
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.apiopen.top/satinApi"]];
    //2.建立网络可变请求
    /*
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:<#(nonnull NSURL *)#> cachePolicy:<#(NSURLRequestCachePolicy)#> timeoutInterval:<#(NSTimeInterval)#>*/
      NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    /*
    NSURLRequestUseProtocolCachePolicy = 0,
    
    NSURLRequestReloadIgnoringLocalCacheData = 1,忽略本地网络缓存:直播
    NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4, // Unimplemented
    NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,
    
    NSURLRequestReturnCacheDataElseLoad = 2,有缓存就加载本地缓存,无缓存加载网络.但是有网有缓存就不加载网络
    NSURLRequestReturnCacheDataDontLoad = 3,//不管有没有缓存都不去加载网络数据,离线应用
    
    NSURLRequestReloadRevalidatingCacheData = 5, // Unimplemented
     */
    //3.设置请求超时时间和http方法
    [requestM setTimeoutInterval:8];
    [requestM setHTTPMethod:@"post"];
    
    //4.包裹数据体
    NSString *dataBodyStr = [NSString stringWithFormat:@"type=%@&page=%@",_userName.text,_password.text];
    NSData *dataBodyData = [dataBodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //5.将二进制数据体附加在可变请求requestM上
    [requestM setHTTPBody:dataBodyData];
    
    //7.发送异步请求
    
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSString *reponseDataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",reponseDataStr);
    }];
    
}

#pragma mark - 连接代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //服务器响应完毕,开始返回数据
    NSLog(@"开始接受服务器的返回请求");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_serverData appendData:data];
    NSLog(@"一次一次接受到的数据:%@",data);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"最终的数据:%@",_serverData);
    //从服务器返回来的数据是jason数据,将jason数据转化为jason对象
     NSError *error = nil;
    id returnJsonObject = [NSJSONSerialization JSONObjectWithData:_serverData options:0 error:&error];
    if ([returnJsonObject isKindOfClass:[NSArray class]]) {
        if (error) {
            NSLog(@"%@",error);
        }
        else{
            
            NSLog(@"%@",(NSArray *)returnJsonObject);
        }
    }
    else{
        if (error) {
            NSLog(@"%@",error);
        }
        else{
            
            NSLog(@"%@",(NSDictionary *)returnJsonObject);
            NSDictionary *jaonDict  = (NSDictionary *)returnJsonObject;
            self.modelArray = [jaonDict objectForKey:@"data"];
        }
    }
    //请求连接成功后,将数据资料清空
    _serverData = nil;
    /*
    NSString *jasonStr = [[NSString alloc] initWithData:_serverData encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jasonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id returnJsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if ([returnJsonObject isKindOfClass:[NSArray class]]) {
        if (error) {
            NSLog(@"%@",error);
        }
        else{
            
            NSLog(@"%@",(NSArray *)returnJsonObject);
        }
    }
    else{
        if (error) {
            NSLog(@"%@",error);
        }
        else{
            
            NSLog(@"%@",(NSDictionary *)returnJsonObject);
        }
    }
    //请求连接成功后,将数据资料清空
    _serverData = nil;
     */
}
//posst发送数据给服务器的
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    NSLog(@"发送数据到服务器 %ld  %ld  %ld",(long)bytesWritten,(long)totalBytesWritten,(long)totalBytesExpectedToWrite);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"多少个模型:%ld",self.modelArray.count);
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NewModel *newModel = [NewModel newModelWithDict:self.modelArray[indexPath.row]];
    cell.textLabel.text = newModel.text;
    //cell.textLabel.text = @"尝试";
    return cell;
}

#pragma mark - 数据获取完毕后去刷新下tableView
- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    [self.tableView reloadData];
}
@end
