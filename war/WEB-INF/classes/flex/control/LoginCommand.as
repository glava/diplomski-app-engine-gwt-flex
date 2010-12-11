package control
{
	import events.LoginEvent;
	
	import model.ToDoLaUser;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class LoginCommand
	{
		[Inject]
		public var toDoModel:ToDoModelLocator;
		private var currentUser:ToDoLaUser;
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public var remoteObject:RemoteObject;
		public function execute (event:LoginEvent) : AsyncToken {
			remoteObject = new RemoteObject("Data");
			currentUser =event.toDoUser;
			return remoteObject.loginUser(event.toDoUser);
		}
		
		public function result (result:ResultEvent) : void {
			toDoModel.currentUser = result.result as ToDoLaUser;
		}
		
		public function error (fault:Fault) : void {
			dispatcher(new LoginEvent(LoginEvent.LOGIN_USER_FAILED,null));
		}
	}
}