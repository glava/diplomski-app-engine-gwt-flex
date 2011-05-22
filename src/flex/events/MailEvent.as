package events
{
	import flash.events.Event;
	
	import model.Mail;

	public class MailEvent extends Event
	{
		public static const SEND_HELP_MAIL:String = "send.help.mail";
		
		public var mail:Mail;
		
		public function MailEvent(type:String,mail:Mail, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.mail = mail;
		}
	}
}