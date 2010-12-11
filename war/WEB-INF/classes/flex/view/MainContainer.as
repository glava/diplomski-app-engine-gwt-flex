package view
{
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import spark.components.SkinnableContainer;
	
	public class MainContainer extends SkinnableContainer
	{
		
		[SkinPart(required="true")]
		public var creatorComponent:CreatorComponent;
		[SkinPart(required="true")]
		public var toDoView:ToDoViewComponent;
		
		public function MainContainer()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE,onPreinitilize);
		}
		
		public function onPreinitilize(evt:FlexEvent):void
		{
			dispatchEvent(new Event("configureView", true));
		}
	}
}