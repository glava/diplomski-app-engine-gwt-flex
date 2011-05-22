package control
{
	import model.ToDo;
	import model.ToDoLaUser;
	
	import mx.collections.ArrayCollection;
	
	import util.ConstUtll;

	public class ToDoModelLocator
	{
		[Bindable]
		public var toDoList:ArrayCollection;
		[Bindable]
		public var doneList:ArrayCollection;
		[Bindable]
		public var currentUser:ToDoLaUser;
		[Bindable]
		public var currentToDo:ToDo;
		
		public var priorityArray:ArrayCollection;
		
		public function ToDoModelLocator():void
		{
			toDoList = new ArrayCollection;
			doneList = new ArrayCollection;
			
			priorityArray = new ArrayCollection();
			priorityArray.addItem(ConstUtll.HIGH_PRIORITY);
			priorityArray.addItem(ConstUtll.MEDIUM_PRIORITY);
			priorityArray.addItem(ConstUtll.LOW_PRIORITY);
		}
	}
}