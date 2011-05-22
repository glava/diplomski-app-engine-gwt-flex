package control
{
	import events.AlertEvent;
	import events.AuthenticateUserEvent;
	
	import model.ToDoLaUser;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class LoginCommand
	{
		[Inject]
		public var toDoModel:ToDoModelLocator;
		[Inject]
		public var sessionCommand:SessionCommand;
		private var currentUser:ToDoLaUser;
		[MessageDispatcher]
		public var dispatcher:Function;
		public var remoteObject:RemoteObject;
		
		public function execute (event:AuthenticateUserEvent) : AsyncToken {
			remoteObject = new RemoteObject("Data");
			currentUser =event.toDoUser;
			return remoteObject.loginUser(event.toDoUser);
		}
		
		public function result (result:ResultEvent) : void {
			if(result.result == null)
			{
				dispatcher(new AlertEvent(AlertEvent.SHOW_ALERT,"Neuspesno logovanja"));
			}
			else{
				toDoModel.currentUser = result.result as ToDoLaUser;
				sessionCommand.set();
			}
		}
		
		public function error (fault:FaultEvent) : void {
			
			dispatcher(new AlertEvent(AlertEvent.SHOW_ALERT,"Neuspesno logovanja"));
		}
	}
}