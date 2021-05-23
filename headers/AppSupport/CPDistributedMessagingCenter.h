#import <Foundation/Foundation.h>

@interface CPDistributedMessagingCenter : NSObject {

	NSString* _centerName;
	NSLock* _lock;
	unsigned _sendPort;
	NSOperationQueue* _asyncQueue;
	CFRunLoopSourceRef _serverSource;
	NSString* _requiredEntitlement;
	NSMutableDictionary* _callouts;
	unsigned _parkedServerPort;
	id _currentCallout;
	unsigned _replyPort;
	BOOL _portPassing;
	BOOL _delayedReply;
	BOOL _requireLookupByPID;
	int _targetPID;

}
+(id)pidRestrictedCenterNamed:(id)arg1 ;
+(id)_centerNamed:(id)arg1 requireLookupByPID:(BOOL)arg2 ;
+(id)centerNamed:(id)arg1 ;
-(id)_requiredEntitlement;
-(BOOL)_sendMessage:(id)arg1 userInfo:(id)arg2 receiveReply:(id*)arg3 error:(id*)arg4 toTarget:(id)arg5 selector:(SEL)arg6 context:(void*)arg7 nonBlocking:(BOOL)arg8 ;
-(BOOL)_isTaskEntitled:(id)arg1 ;
-(void)setTargetPID:(int)arg1 ;
-(void)sendDelayedReply:(id)arg1 dictionary:(id)arg2 ;
-(void)registerForMessageName:(id)arg1 target:(id)arg2 selector:(SEL)arg3 ;
-(unsigned)_sendPort;
-(unsigned)_serverPort;
-(void)_dispatchMessageNamed:(id)arg1 userInfo:(id)arg2 reply:(id*)arg3 auditToken:(id)arg4 ;
-(void)stopServer;
-(void)dealloc;
-(void)sendMessageAndReceiveReplyName:(id)arg1 userInfo:(id)arg2 toTarget:(id)arg3 selector:(SEL)arg4 context:(void*)arg5 ;
-(void)unregisterForMessageName:(id)arg1 ;
-(void)_setSendPort:(unsigned)arg1 ;
-(id)_initWithServerName:(id)arg1 ;
-(BOOL)sendMessageName:(id)arg1 userInfo:(id)arg2 ;
-(void)runServerOnCurrentThread;
-(void)runServerOnCurrentThreadProtectedByEntitlement:(id)arg1 ;
-(BOOL)_sendMessage:(id)arg1 userInfoData:(id)arg2 oolKey:(id)arg3 oolData:(id)arg4 makeServer:(BOOL)arg5 receiveReply:(id*)arg6 nonBlocking:(BOOL)arg7 error:(id*)arg8 ;
-(id)delayReply;
-(id)sendMessageAndReceiveReplyName:(id)arg1 userInfo:(id)arg2 error:(id*)arg3 ;
-(id)_initAnonymousServer;
-(void)_setupInvalidationSource;
-(id)_initWithServerName:(id)arg1 requireLookupByPID:(BOOL)arg2 ;
-(id)_initClientWithPort:(unsigned)arg1 ;
-(BOOL)_sendMessage:(id)arg1 userInfo:(id)arg2 receiveReply:(id*)arg3 error:(id*)arg4 toTarget:(id)arg5 selector:(SEL)arg6 context:(void*)arg7 ;
-(BOOL)doesServerExist;
-(id)name;
-(void)_sendReplyMessage:(id)arg1 portPassing:(BOOL)arg2 onMachPort:(unsigned)arg3 ;
-(BOOL)sendNonBlockingMessageName:(id)arg1 userInfo:(id)arg2 ;
-(id)sendMessageAndReceiveReplyName:(id)arg1 userInfo:(id)arg2 ;
@end
