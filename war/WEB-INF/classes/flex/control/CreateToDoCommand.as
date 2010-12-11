package control
{
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
		
		private var newToDo:ToDo;
		
		public function CreateToDoCommand()
		{
			remoteObject = new RemoteObject("Data");
			remoteObject.addEventListener(FaultEvent.FAULT,onFaultEvent);
		}
	
		[MessageHandler(type="events.CreateToDoEvent", selector="Create.To.Do")]
		public function createToDo(evt:CreateToDoEvent):void
		{
			/*TODO do this from model*/
			var toDoUser:ToDoLaUser = new ToDoLaUser;
			toDoUser.username = "goran";
			
			
			newToDo = new ToDo(evt.toDoMsg,evt.date,evt.priority);
			remoteObject.createToDo.addEventListener(ResultEvent.RESULT,onResult);
			remoteObject.createToDo(toDoUser,newToDo);
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