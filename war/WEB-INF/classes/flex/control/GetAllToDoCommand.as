package control
{
	import events.ToDoEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;

	public class GetAllToDoCommand
	{
	
		public var remoteObject:RemoteObject;
		[MessageDispatcher]
		public var dispatcher:Function;
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		public function execute (event:ToDoEvent) : AsyncToken {
		
			remoteObject = new RemoteObject("Data");
			return remoteObject.getToDoList(event.toDoUser);
		}
		
		public function result (toDoList:ArrayCollection) : void {
			toDoModelLocator.toDoList = toDoList;
			dispatcher(new ToDoEvent(ToDoEvent.ALL_TO_DO_DONE,null,true));
		}
		
		public function error (fault:Fault) : void {
			// do something with the result
		}
	}
}