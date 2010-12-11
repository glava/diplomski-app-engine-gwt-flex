package events
{
	import flash.events.Event;
	
	public class CheckSessionEvent extends Event
	{
		public static const START_CHECKING:String = "check.session.event.start";
		
		public function CheckSessionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}