package model
{
	[Bindable]
	[RemoteClass(alias="goran.com.jdo.ToDoUser")]
	public class ToDoLaUser
	{
		public var username:String;
		public var password:String;
		public var toDoTasks:Array;
	}
}