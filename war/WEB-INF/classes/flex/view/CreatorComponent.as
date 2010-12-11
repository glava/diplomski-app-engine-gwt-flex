package view
{
	import control.ToDoModelLocator;
	
	import events.CreateToDoEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.ToDo;
	
	import mx.controls.DateField;
	import mx.controls.Label;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.DropDownList;
	import spark.components.SkinnableContainer;
	import spark.components.TextArea;

	public class CreatorComponent extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var toDoMsg:TextArea;
		
		[SkinPart(required="true")]
		public var date:DateField;
		
		[SkinPart(required="true")]
		public var priority:DropDownList;
		
		[SkinPart(required="true")]
		public var btnCreate:Button;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		/*[SkinPart(required="true")]
		public var lblCancel:Label;*/
		
		public function CreatorComponent()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE,onPreinitilize);
		}
		
		public function onPreinitilize(evt:FlexEvent):void
		{
			dispatchEvent(new Event("configureView", true));
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == btnCreate)
			{
				btnCreate.addEventListener(MouseEvent.CLICK,onCreateToDo);
			}
			/*if(instance == lblCancel)
			{
				lblCancel.addEventListener(MouseEvent.CLICK,onCancelToDo);
			}*/
		}
		
		private function onCreateToDo(evt:MouseEvent):void
		{
			/*create todo and create service*/
			var createToDoEvent:CreateToDoEvent = new CreateToDoEvent(CreateToDoEvent.CREATE_TO_DO,true);
			createToDoEvent.date = date.selectedDate;
			createToDoEvent.toDoMsg = toDoMsg.text;
			createToDoEvent.priority = 1;
			dispatcher(createToDoEvent);
			
		}
		private function onCancelToDo(evt:MouseEvent):void
		{
			/*clear fild*/
		}
		
		
		
	}
}