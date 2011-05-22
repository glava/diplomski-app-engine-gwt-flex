package control
{
	import events.AlertEvent;
	import events.MailEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SendHelpMailCommand
	{
		public var remoteObject:RemoteObject;
		[MessageDispatcher]
		public var dispatcher:Function;
		public function execute (event:MailEvent) : AsyncToken {
			remoteObject = new RemoteObject("Data");
			return remoteObject.sendMail(event.mail);
		}
		
		public function result (result:ResultEvent) : void {
			
			dispatcher(new AlertEvent(AlertEvent.SHOW_ALERT,"mail result"));
		
		}
		
		
		public function error (fault:FaultEvent) : void {
			dispatcher(new AlertEvent(AlertEvent.SHOW_ALERT,"mail error"));
		}
	}
}