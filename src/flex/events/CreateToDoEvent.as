package events
{
	import flash.events.Event;
	
	import model.ToDo;
	
	public class CreateToDoEvent extends Event
	{
		public static const CREATE_TO_DO:String = "Create.To.Do";
		public static const UPDATE_TO_DO:String = "Update.To.Do";
		public static const DELETE_TO_DO:String = "Delete.To.Do";
		public var toDo:ToDo;
		
		public function CreateToDoEvent(type:String, toDo:ToDo=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.toDo = toDo;
		}
	}
}