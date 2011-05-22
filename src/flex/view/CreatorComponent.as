	package view
{
	import control.ToDoModelLocator;
	
	import events.CreateToDoEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.ToDo;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DateField;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.DropDownList;
	import spark.components.SkinnableContainer;
	import spark.components.TextArea;
	
	import util.ToDoConverter;

	public class CreatorComponent extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var toDoMsg:TextArea;
		
		[SkinPart(required="true")]
		public var dateField:DateField;
		
		[SkinPart(required="true")]
		public var priority:DropDownList;
		
		[SkinPart(required="true")]
		public var btnCreate:Button;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		
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
		}
		
		[Init]
		public function init():void
		{
			priority.dataProvider = toDoModelLocator.priorityArray;
		}
		
		private function onCreateToDo(evt:MouseEvent):void
		{
			/*create todo and create service*/
			
			var toDo:ToDo =ToDoConverter.convertProperites2ToDo(toDoMsg.text,new Date(),priority.selectedIndex,false,"");
			dispatcher( new CreateToDoEvent(CreateToDoEvent.CREATE_TO_DO,toDo));
			
		}
		private function onCancelToDo(evt:MouseEvent):void
		{
			toDoMsg.text = "";
		}
		
		
		
	}
}