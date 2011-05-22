package events
{
	import flash.events.Event;
	import model.ToDo;
	import model.ToDoLaUser;
	
	public class AuthenticateUserEvent extends Event
	{
		public static const LOGIN_USER:String = "Log.In.User";
		public static const REGISTER_USER:String = "Register.User";
		public static const REGISTER_USER_FAILED:String = "Register.User.Failed";
		public static const LOGIN_USER_FAILED:String = "Log.In.User.Failed";
		public static const LOGOUT_USER:String = "Log.Out.User.Failed";

		public var toDoUser:ToDoLaUser;
		public function AuthenticateUserEvent(type:String,toDoUser:ToDoLaUser, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.toDoUser = toDoUser;
			super(type, bubbles, cancelable);
		}
	}
}