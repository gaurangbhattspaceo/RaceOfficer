//
//  AccountObject.h
//  CurrentCostApp


@interface AccountObject : NSMutableDictionary

@property (nonatomic, assign) int               customer_id;
@property (nonatomic, strong) NSString          *email;
@property (nonatomic, strong) NSString          *firstname;
@property (nonatomic, strong) NSString          *lastname;
@property (nonatomic, strong) NSString          *session;



+ (AccountObject*)accountInfoFromUserDefault;

@end
