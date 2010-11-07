package model
{	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="goran.com.model.ToDoVo")]
	public class ToDo
	{
		
		public var toDoMsg:String;
		public var date:Date;
		public var tags:ArrayCollection;
		public var priority:int;
		
		public function ToDo(toDoMsg:String,date:Date = null,tags:ArrayCollection = null,priority:int=0)
		{
			this.toDoMsg = toDoMsg;
			this.date = date;
			this.tags = tags;
			this.priority = priority;
		}
		
	}
}