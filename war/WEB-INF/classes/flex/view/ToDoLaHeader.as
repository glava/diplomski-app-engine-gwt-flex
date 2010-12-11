package view
{
	import control.ToDoModelLocator;
	
	import events.CheckSessionEvent;
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	
	public class ToDoLaHeader extends SkinnableContainer
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var toDoModel:ToDoModelLocator;
		
		[SkinPart(required="true")]
		public var title:Label;
		
		public function ToDoLaHeader()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE,onPreinitialize);
			
		}
		
		public function onPreinitialize(evt:Event):void
		{
			
			dispatchEvent(new Event("configureView", true));
				
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance); 
			if(instance == title)
			{
				trace("");
			}
				
		}
	}
}