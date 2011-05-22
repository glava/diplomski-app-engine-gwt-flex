package control
{
	import events.AlertEvent;
	import events.CreateToDoEvent;
	
	import model.Priority;
	import model.Tag;
	import model.ToDo;
	import model.ToDoLaUser;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class CreateToDoCommand
	{
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		public var remoteObject:RemoteObject;
		[MessageDispatcher]
		public var dispatcher:Function;
		private var newToDo:ToDo;
		
		public function CreateToDoCommand()
		{
			remoteObject = new RemoteObject("Data");
			remoteObject.addEventListener(FaultEvent.FAULT,onFaultEvent);
		}
	
		[MessageHandler(type="events.CreateToDoEvent", selector="Create.To.Do")]
		public function createToDo(evt:CreateToDoEvent):void
		{
			var toDoUser:ToDoLaUser = new ToDoLaUser;
			toDoUser.username = toDoModelLocator.currentUser.username;
			remoteObject.createToDo.addEventListener(ResultEvent.RESULT,onResult);
			newToDo = evt.toDo;
			remoteObject.createToDo(toDoUser,evt.toDo);
		}
		
		public function onFaultEvent(evt:FaultEvent):void
		{
			dispatcher(new AlertEvent(AlertEvent.SHOW_ALERT,"Neuspesno kreiranje toDo-a"));
		}
		public function onResult(evt:ResultEvent):void
		{
			toDoModelLocator.toDoList.addItem(newToDo);
		}
	}
}