package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="goran.com.model.ToDoUserVo")]
	public class ToDoLaUser
	{
		public var username:String;
		public var password:String;
	}
}