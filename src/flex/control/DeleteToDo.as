package control
{
	import events.CreateToDoEvent;
	
	import model.ToDo;
	import model.ToDoLaUser;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	public class DeleteToDo
	{
	
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		public var remoteObject:RemoteObject;
		
		private var newToDo:ToDo;
		
		public function DeleteToDo()
		{
			remoteObject = new RemoteObject("Data");
			remoteObject.addEventListener(FaultEvent.FAULT,onFaultEvent);
		}
		
		[MessageHandler(type="events.CreateToDoEvent", selector="Delete.To.Do")]
		public function deleteToDo(evt:CreateToDoEvent):void
		{
			var toDoUser:ToDoLaUser = new ToDoLaUser;
			newToDo = evt.toDo;
			toDoUser.username = toDoModelLocator.currentUser.username;
			remoteObject.deleteToDo.addEventListener(ResultEvent.RESULT,onResult);
			remoteObject.deleteToDo(toDoUser,evt.toDo);
		}
		
		public function onResult(evt:ResultEvent):void
		{
			if(evt.result!=null)
			{
				if(toDoModelLocator.toDoList.contains(newToDo))
				{
					toDoModelLocator.toDoList.removeItemAt(toDoModelLocator.toDoList.getItemIndex(newToDo));
					toDoModelLocator.toDoList.refresh();
				}
				if(toDoModelLocator.doneList.contains(newToDo))
				{
					toDoModelLocator.doneList.removeItemAt(toDoModelLocator.doneList.getItemIndex(newToDo));
					toDoModelLocator.toDoList.refresh();
				}
			}
		}
		public function onFaultEvent(evt:FaultEvent):void
		{
			
		}
	}
}