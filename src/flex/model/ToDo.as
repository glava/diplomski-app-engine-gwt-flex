package model
{	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="goran.com.model.ToDoVo")]
	public class ToDo
	{
		
		public var toDoMsg:String;
		public var date:Date;
		public var priority:int;
		public var done:Boolean;
		public var key:String;
		
	}
}