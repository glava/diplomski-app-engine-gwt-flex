package control
{
	import events.CheckSessionEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
		public class SessionCommand
		{
			public var httpService:HTTPService;
			[MessageDispatcher]
			public var dispatcher:Function;
			[Inject]
			public var toDoModel:ToDoModelLocator;
			
			public function set():void
			{
				httpService = new HTTPService();
				httpService.url = Globals.SET_SESSION_SERVLET;
				httpService.method = "POST";
				httpService.addEventListener(ResultEvent.RESULT,onSessionResult);
				httpService.addEventListener(FaultEvent.FAULT,onSessionFault);
				var params:Object = new Object();
				params.param1 = toDoModel.currentUser.username;
				httpService.send(params);
			}
			public function clean():void
			{
				httpService = new HTTPService();
				httpService.url = Globals.CLEAN_SESSION_SERVLET;
				httpService.method = "GET";
				httpService.addEventListener(ResultEvent.RESULT,onSessionResult);
				httpService.addEventListener(FaultEvent.FAULT,onSessionFault);
				httpService.send();
			}
			
			public function onSessionResult(evt:ResultEvent):void
			{
				if((evt.result as String) == "user")
				{
					
				}
			}
			public function onSessionFault(evt:FaultEvent):void
			{
				//dispatcher(new CheckSessionEvent(CheckSessionEvent.USER_NOT_IN_SESSION));	
			}
		}
	
}