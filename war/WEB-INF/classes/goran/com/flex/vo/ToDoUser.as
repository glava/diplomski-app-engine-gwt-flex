package goran.com.flex.vo
{
	[Bindable]
	[RemoteClass(alias="goran.com.jdo.ToDoUser")]
	public class ToDoUser
	{
		public var username:String;
		public var password:String;
		
		public function ToDoUser()
		{
		}
	}
}