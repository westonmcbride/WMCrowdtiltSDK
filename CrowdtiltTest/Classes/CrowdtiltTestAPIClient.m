#import "CrowdtiltTestAPIClient.h"
#import "AFJSONRequestOperation.h"

//static NSString * const kCrowdtiltTestAPIBaseURLString = @"http://api.crowdtilt.com/v1/";
static NSString * const kCrowdtiltTestAPIBaseURLString = @"https://api-sandbox.crowdtilt.com/v1/";
static NSString * const kCrowdtiltAPIKey = @"f7f43fb9ba85cb486781b66fc6fd8f";
static NSString * const kCrowdtiltAPISecret = @"49c54a6f3752ddacad8e1d0e3b3906602515a4e5";

@implementation CrowdtiltTestAPIClient

+ (CrowdtiltTestAPIClient *)sharedClient {
    static CrowdtiltTestAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kCrowdtiltTestAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
	[self setParameterEncoding:AFJSONParameterEncoding]; // test
	[self setAuthorizationHeaderWithUsername:kCrowdtiltAPIKey password:kCrowdtiltAPISecret];
    
    return self;
}

#pragma mark - AFIncrementalStore

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    return responseObject;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation 
                                     ofEntity:(NSEntityDescription *)entity 
                                 fromResponse:(NSHTTPURLResponse *)response 
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    // Customize the response object to fit the expected attribute keys and values  
    
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

@end
