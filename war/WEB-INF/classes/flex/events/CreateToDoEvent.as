package events
{
	import flash.events.Event;
	
	public class CreateToDoEvent extends Event
	{
		public static const CREATE_TO_DO:String = "Create.To.Do";
		
		public var date:Date;
		public var toDoMsg:String;
		public var priority:int;
		
		public function CreateToDoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}