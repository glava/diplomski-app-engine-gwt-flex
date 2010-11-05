package control
{
	import model.Priority;
	import model.ToDo;
	import model.ToDoLaUser;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class CreateToDoCommand
	{
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		public var remoteObject:RemoteObject;
		
		private var newToDo:ToDo;
		
		public function CreateToDoCommand()
		{
			remoteObject = new RemoteObject("Data");
			remoteObject.addEventListener(FaultEvent.FAULT,onFaultEvent);
		}
		public function createToDo(toDoMsg:String,date:Date = null,tag:Array = null,priority:Priority=null)
		{
			newToDo = new ToDo(toDoMsg,date,tag,priority);
			var toDoUser:ToDoLaUser = new ToDoLaUser;
			toDoUser.username = "goran";
			toDoUser.toDoTasks = new Array();
			toDoUser.password = "";
			toDoUser.toDoTasks.push(newToDo);
			remoteObject.createToDo.addEventListener(ResultEvent.RESULT,onResult);
			remoteObject.createToDo(toDoUser);
		}
		
		public function onFaultEvent(evt:FaultEvent):void
		{
		  	
		}
		public function onResult(evt:ResultEvent):void
		{
			toDoModelLocator.toDoList.addItem(newToDo);  	
		}
	}
}