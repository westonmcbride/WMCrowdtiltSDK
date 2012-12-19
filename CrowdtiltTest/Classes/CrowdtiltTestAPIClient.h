#import "AFIncrementalStore.h"
#import "AFRestClient.h"

@interface CrowdtiltTestAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (CrowdtiltTestAPIClient *)sharedClient;

@end
