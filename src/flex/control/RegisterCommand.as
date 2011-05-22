package control
{
	import events.AuthenticateUserEvent;
	
	import model.ToDoLaUser;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class RegisterCommand
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
			return remoteObject.registerUser(event.toDoUser);
		}
		
		public function result (result:ResultEvent) : void {
			toDoModel.currentUser = result.result as ToDoLaUser;
			sessionCommand.set();
		}
		
		public function error (fault:FaultEvent) : void {
			dispatcher(new AuthenticateUserEvent(AuthenticateUserEvent.LOGIN_USER_FAILED,null));
		}
	}
}