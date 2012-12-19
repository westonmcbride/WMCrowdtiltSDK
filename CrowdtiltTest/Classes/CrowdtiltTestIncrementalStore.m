#import "CrowdtiltTestIncrementalStore.h"
#import "CrowdtiltTestAPIClient.h"

@implementation CrowdtiltTestIncrementalStore

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CrowdtiltTest" withExtension:@"xcdatamodeld"]];
}

- (id <AFIncrementalStoreHTTPClient>)HTTPClient {
    return [CrowdtiltTestAPIClient sharedClient];
}

@end