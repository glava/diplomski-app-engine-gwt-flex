package util
{
	import model.ToDo;

	public class ToDoConverter
	{
		public function ToDoConverter()
		{
		}
		public static function convertProperites2ToDo(toDoMsg:String,date:Date, priority:int, done:Boolean,key:String = ""):ToDo
		{
			var toDo:ToDo = new ToDo;
			toDo.date = date;
			toDo.toDoMsg = toDoMsg;
			if(priority<0)
			{
				priority = 0;
			}
			toDo.priority = priority;
			toDo.done = done;
			toDo.key = key;
			return toDo;	
		}
	}
}