#import "CrowdtiltTestAPIClient.h"
#import "AFJSONRequestOperation.h"

//static NSString * const kCrowdtiltTestAPIBaseURLString = @"http://api.crowdtilt.com/v1/";
static NSString * const kCrowdtiltTestAPIBaseURLString = @"https://api-sandbox.crowdtilt.com/v1/";
static NSString * const kCrowdtiltAPIKey = @"your key";
static NSString * const kCrowdtiltAPISecret = @"your secret";

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
    return [responseObject objectForKey:@"campaigns"];
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation 
                                     ofEntity:(NSEntityDescription *)entity 
                                 fromResponse:(NSHTTPURLResponse *)response 
{
   	//NSLog(@"attributes: %@, %@, %@", representation, entity, response);
	
	NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    //**** Customize the response object to fit the expected attribute keys and values
	
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return [[[objectID entity] name] isEqualToString:@"Campaign"];
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return [[[objectID entity] name] isEqualToString:@"Campaign"];
}

@end
