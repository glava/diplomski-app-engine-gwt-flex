package control
{
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
		public function createToDo(toDoMsg:String,date:Date = null,tags:ArrayCollection = null,priority:int=0)
		{
			var toDoUser:ToDoLaUser = new ToDoLaUser;
			toDoUser.username = "goran";
			var tag:Tag = new Tag;
			tag.name = "posao";
			var tag1:Tag = new Tag;
			tag1.name = "kuca";
			tags = new ArrayCollection;
			tags.addItem(tag);
			tags.addItem(tag1);
			var toDo:ToDo = new ToDo(toDoMsg,date,tags,1);
			remoteObject.createToDo.addEventListener(ResultEvent.RESULT,onResult);
			remoteObject.createToDo(toDoUser,toDo);
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