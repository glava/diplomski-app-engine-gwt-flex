package events
{
	import flash.events.Event;
	
	public class AlertEvent extends Event
	{
		public static const SHOW_ALERT:String= "Show.Alert";
		public var alertMsg:String;
		
		public function AlertEvent(type:String,alertMsg:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.alertMsg = alertMsg;
		}
	}
}