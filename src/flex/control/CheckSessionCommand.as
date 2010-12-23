package control
{
	import events.CheckSessionEvent;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class CheckSessionCommand
	{
		public var httpService:HTTPService;
		
		
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
			trace();
		}
		public function onSessionFault(evt:FaultEvent):void
		{
		   trace();	
		}
	}
}