package model
{	
	[Bindable]
	[RemoteClass(alias="goran.com.jdo.ToDo")]
	public class ToDo
	{
		public var toDoMsg:String;
		public var date:Date;
		public var tag:Array;
		public var priority:Priority;
		
		public function ToDo(toDoMsg:String,date:Date = null,tag:Array = null,priority:Priority=null)
		{
			this.toDoMsg = toDoMsg;
			this.date = date;
			this.tag = tag;
			this.priority = priority;
		}
		
	}
}