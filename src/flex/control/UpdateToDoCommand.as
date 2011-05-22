package control
{
	import events.CreateToDoEvent;
	
	import model.ToDo;
	import model.ToDoLaUser;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class UpdateToDoCommand
	{
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		public var remoteObject:RemoteObject;
		
		private var newToDo:ToDo;
	
		public function UpdateToDoCommand()
		{
			remoteObject = new RemoteObject("Data");
			remoteObject.addEventListener(FaultEvent.FAULT,onFaultEvent);
		}
		
		[MessageHandler(type="events.CreateToDoEvent", selector="Update.To.Do")]
		public function updateToDo(evt:CreateToDoEvent):void
		{
			var toDoUser:ToDoLaUser = new ToDoLaUser;
			newToDo = evt.toDo;
			toDoUser.username = toDoModelLocator.currentUser.username;
			remoteObject.updateToDoVo.addEventListener(ResultEvent.RESULT,onResult);
			remoteObject.updateToDoVo(toDoUser,evt.toDo);
		}
		
		public function onFaultEvent(evt:FaultEvent):void
		{
			
		}
		public function onResult(evt:ResultEvent):void
		{
			if(newToDo.done)
			{
				toDoModelLocator.doneList.addItem(newToDo);
				toDoModelLocator.doneList.refresh();
				if(toDoModelLocator.toDoList.contains(newToDo))
				{
					toDoModelLocator.toDoList.removeItemAt(toDoModelLocator.toDoList.getItemIndex(newToDo));
					toDoModelLocator.toDoList.refresh();
				}
			}
			else
			{
				/*dodaje u toDo listu ako treba*/
				if(!toDoModelLocator.toDoList.contains(newToDo))
				{
					toDoModelLocator.toDoList.addItem(newToDo);
					toDoModelLocator.toDoList.refresh();
				}
				/*dodaje u done listu ako treba */
				if(toDoModelLocator.doneList.contains(newToDo))
				{
					toDoModelLocator.doneList.removeItemAt(toDoModelLocator.doneList.getItemIndex(newToDo));
					toDoModelLocator.doneList.refresh();
				}
			}
		}
	}
}