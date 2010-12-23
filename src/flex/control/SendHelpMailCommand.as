package control
{
	import events.MailEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SendHelpMailCommand
	{
		public var remoteObject:RemoteObject;
		
		public function execute (event:MailEvent) : AsyncToken {
			remoteObject = new RemoteObject("Data");
			
			return remoteObject.sendMail();
			
		}
		
		public function result (result:ResultEvent) : void {
		}
		
		public function error (fault:FaultEvent) : void {
			
		}
	}
}