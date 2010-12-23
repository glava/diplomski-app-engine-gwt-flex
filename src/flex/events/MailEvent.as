package events
{
	import flash.events.Event;

	public class MailEvent extends Event
	{
		public static const SEND_HELP_MAIL:String = "send.help.mail";
		
		public function MailEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}