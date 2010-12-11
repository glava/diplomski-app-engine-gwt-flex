package control
{
	import model.ToDo;
	import model.ToDoLaUser;
	
	import mx.collections.ArrayCollection;

	public class ToDoModelLocator
	{
		[Bindable]
		public var toDoList:ArrayCollection;
		[Bindable]
		public var currentUser:ToDoLaUser;
		
		public function ToDoModelLocator():void
		{
			toDoList = new ArrayCollection;
		}
	}
}