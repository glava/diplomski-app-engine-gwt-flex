package control
{
	import events.CheckSessionEvent;
	import events.AlertEvent;
	import events.AuthenticateUserEvent;
	
	import model.ToDoLaUser;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	public class LogoutCommand
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
			return remoteObject.logOut(event.toDoUser);
		}
		
		public function result (result:ResultEvent) : void {
			if(result.result == true)
			{
				
			}
			toDoModel.currentToDo = null;
			toDoModel.toDoList.removeAll();
			toDoModel.doneList.removeAll();
			toDoModel.currentUser = null;
			dispatcher(new CheckSessionEvent(CheckSessionEvent.USER_NOT_IN_SESSION,true));
		}
		
		public function error (fault:FaultEvent) : void {
			dispatcher(new AuthenticateUserEvent(AuthenticateUserEvent.LOGIN_USER_FAILED,null));
		}
	}
}