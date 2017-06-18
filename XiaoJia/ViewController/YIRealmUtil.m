//
// Created by efeng on 16/9/3.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIRealmUtil.h"
#import "YIExpensesTag.h"
#import "YIIncomeTag.h"
#import "YIFrequency.h"

@interface YIRealmUtil() {
	RLMRealm *realm;
}

@end

@implementation YIRealmUtil


+ (YIRealmUtil *)instance {
    static YIRealmUtil *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSURL *)getAppMainDBUrl {
	NSString *filePath = [[[YIFileUtil appDocumentDirectory]
						   stringByAppendingPathComponent:@"bill"]
						  stringByAppendingPathExtension:@"realm"];
	NSURL *fileURL = [NSURL fileURLWithPath:filePath];
	NSLog(@"数据库的位置: %@",fileURL);
	return fileURL;
}

// 【1】配置并初始化应用主数据库
- (void)initRealm {
    // 自定义数据库的位置和名字
	NSURL *fileURL = [self getAppMainDBUrl];
	// 获取默认的数据库配置
	RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
	// 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
	config.schemaVersion = 2;
	// 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
	config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
		// 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
		if (oldSchemaVersion < 2) {
			// enumerateObjects:block: 方法遍历了存储在 Realm 文件中的每一个“Person”对象
			[migration enumerateObjects:YIIncomeTag.className
								  block:^(RLMObject *oldObject, RLMObject *newObject) {
									  // 将名字进行合并，存放在 fullName 域中
//									  newObject[@"id"] = @9527;
									  NSLog(@"old obj = %@", oldObject[@"iconName"]);
									  NSLog(@"new obj = %@", newObject[@"iconName"]);
								  }];
		}
	};
    [config setFileURL:fileURL];
    [RLMRealmConfiguration setDefaultConfiguration:config];
	
//	// 按新的配置创建数据库
//	realm  = [RLMRealm defaultRealm];
	
    // 默认值导入到主数据库中
    NSURL *defaultDataUrl = [[NSBundle mainBundle] URLForResource:@"default-data" withExtension:@"realm"];
	[[NSFileManager defaultManager] copyItemAtURL:defaultDataUrl toURL:fileURL error:nil];
/*
//	// set schemave versions and migration blocks form Realms at each path
	RLMRealmConfiguration *realmv1Configuration = [config copy];
	realmv1Configuration.fileURL = defaultDataUrl;
//	
//	// manully migration v1Path, v2Path is migrated implicitly on access
	[RLMRealm migrateRealm:realmv1Configuration];
 */
}

// 【import default data tool】
- (void)buildDefaultData {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // https://realm.io/cn/docs/objc/latest/#realm--5
    // 默认值数据库的位置
    NSString *defaultDataFilePath = [[[YIFileUtil appDocumentDirectory]
            stringByAppendingPathComponent:@"default-data"]
            stringByAppendingPathExtension:@"realm"];
    NSURL *defaultDataFileURL = [NSURL fileURLWithPath:defaultDataFilePath];
    NSLog(@"默认值数据库的位置: %@",defaultDataFileURL);

    [config setFileURL:defaultDataFileURL];
    [RLMRealmConfiguration setDefaultConfiguration:config];

    realm = [RLMRealm defaultRealm];

    // 在生成 Realm 文件的代码处，您需要结尾对文件进行压缩拷贝（参见 -[RLMRealm writeCopyToPath:error:]）。
    // 这有助于减少 Realm 的文件体积，让您发布的应用体积更小；
    [realm writeCopyToURL:defaultDataFileURL encryptionKey:nil error:nil];

	// 导入默认数据
	[self importExpensesTagDefaultData:realm];
    [self importIncomeTagDefaultData:realm];
    [self importFrequencyDefaultData:realm];
	
	// 最后删除原有的数据库文件
	[[NSFileManager defaultManager] removeItemAtURL:[self getAppMainDBUrl] error:nil];
}

- (void)importIncomeTagDefaultData:(RLMRealm *)realm {
    // Import JSON
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"income-tag" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *error = nil;
    NSArray *incomeTags = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:0
                                                            error:&error];
    if (error) {
        NSLog(@"There was an error reading the JSON file: %@", error.localizedDescription);
        return;
    }

    [realm beginWriteTransaction];
    // Add Person objects in realm for every person dictionary in JSON array
    for (NSDictionary *incomeTag in incomeTags) {
        YIIncomeTag *tag = [[YIIncomeTag alloc] init];
        tag.id = [incomeTag[@"id"] integerValue];
        tag.name = incomeTag[@"name"];
        tag.remarks = incomeTag[@"remarks"];
		tag.iconName = incomeTag[@"iconName"];
        [realm addObject:tag];
    }
    [realm commitWriteTransaction];

    // Print all persons from realm
    for (YIIncomeTag *person in [YIIncomeTag allObjects]) {
        NSLog(@"YIIncomeTag persisted to realm: %@", person);
    }
}

- (void)importExpensesTagDefaultData:(RLMRealm *)realm {
    // Import JSON
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"expenses-tag" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *error = nil;
    NSArray *incomeTags = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:0
                                                            error:&error];
    if (error) {
        NSLog(@"There was an error reading the JSON file: %@", error.localizedDescription);
        return;
    }

    [realm beginWriteTransaction];
    // Add Person objects in realm for every person dictionary in JSON array
    for (NSDictionary *incomeTag in incomeTags) {
        YIExpensesTag *tag = [[YIExpensesTag alloc] init];
        tag.id = [incomeTag[@"id"] integerValue];
        tag.name = incomeTag[@"name"];
        tag.remarks = incomeTag[@"remarks"];
		tag.iconName = incomeTag[@"iconName"];
        [realm addObject:tag];
    }
    [realm commitWriteTransaction];

    // Print all persons from realm
    for (YIExpensesTag *person in [YIExpensesTag allObjects]) {
        NSLog(@"YIExpenses persisted to realm: %@", person);
    }
}

- (void)importFrequencyDefaultData:(RLMRealm *)realm {
    // Import JSON
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"frequency" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:0
                                                            error:&error];
    if (error) {
        NSLog(@"There was an error reading the JSON file: %@", error.localizedDescription);
        return;
    }

    [realm beginWriteTransaction];
    // Add Person objects in realm for every person dictionary in JSON array
    for (NSDictionary *item in array) {
        YIFrequency *tag = [[YIFrequency alloc] init];
        tag.id = [item[@"id"] integerValue];
        tag.name = item[@"name"];
        tag.remarks = item[@"remarks"];
        [realm addObject:tag];
    }
    [realm commitWriteTransaction];

    // Print all persons from realm
    for (YIFrequency *person in [YIFrequency allObjects]) {
        NSLog(@"YIFrequency persisted to realm: %@", person);
    }
}


@end
