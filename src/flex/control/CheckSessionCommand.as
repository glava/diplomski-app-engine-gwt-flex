package control
{
	import events.CheckSessionEvent;
	import events.ToDoEvent;
	
	import model.ToDoLaUser;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class CheckSessionCommand
	{
		public var httpService:HTTPService;
		[MessageDispatcher]
		public var dispatcher:Function;
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		
		public function execute():void
		{
			httpService = new HTTPService();
			httpService.url = Globals.CHECK_SESSION_SERVLET;
			httpService.method = "GET";
			httpService.addEventListener(ResultEvent.RESULT,onSessionResult);
			httpService.addEventListener(FaultEvent.FAULT,onSessionFault);
			httpService.send();
		}
		
		public function onSessionResult(evt:ResultEvent):void
		{
			var username:String = evt.result as String;
			if(username.search("null")>-1)
			{
				dispatcher(new CheckSessionEvent(CheckSessionEvent.USER_NOT_IN_SESSION));	
			}
			else
			{
				dispatcher(new CheckSessionEvent(CheckSessionEvent.USER_IN_SESSION));
				var toDoUser:ToDoLaUser = new ToDoLaUser;
				toDoUser.username = username.substring(0,username.search("%"));
				toDoModelLocator.currentUser = toDoUser;
				/*dispatcher(new ToDoEvent(ToDoEvent.GET_ALL_TODOS,toDoUser,true));*/
			}
		}
		public function onSessionFault(evt:FaultEvent):void
		{
			dispatcher(new CheckSessionEvent(CheckSessionEvent.USER_NOT_IN_SESSION));	
		}
		
		public function stripspaces(originalstring:String):String
		{
			var original:Array=originalstring.split(" ");
			return(original.join(""));
		}
	}
}