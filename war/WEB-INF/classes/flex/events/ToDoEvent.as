package events
{
	import flash.events.Event;
	
	import model.ToDoLaUser;
	
	public class ToDoEvent extends Event
	{
		public static const GET_ALL_TODOS:String = "Get.All.To.Do.Objects"; 
		public static const ALL_TO_DO_DONE:String = "All.To.Do.Done"; 
		
		
		public var toDoUser:ToDoLaUser;
		
		public function ToDoEvent(type:String, toDoUser:ToDoLaUser, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.toDoUser = toDoUser;
			super(type, bubbles, cancelable);
		}
	}
}