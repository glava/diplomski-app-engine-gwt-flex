package events
{
	import flash.events.Event;
	
	public class CheckSessionEvent extends Event
	{
		public static const START_CHECKING:String = "check.session.event.start";
		public static const USER_IN_SESSION:String = "user.in.session.event";
		public static const USER_NOT_IN_SESSION:String = "user.not.in.session.event";
		
		public function CheckSessionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}