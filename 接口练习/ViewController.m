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
    
    NSString *urlStr = [NSString stringWithFormat:@"https://www.apiopen.top/satinApi?type=%@&page=%@",_userName.text,_password.text];
    //NSURL *url = [NSURL URLWithString:urlStr];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSHTTPURLResponse
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection start];
    
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
    return cell;
}

#pragma mark - 数据获取完毕后去刷新下tableView
- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    [self.tableView reloadData];
}
@end
