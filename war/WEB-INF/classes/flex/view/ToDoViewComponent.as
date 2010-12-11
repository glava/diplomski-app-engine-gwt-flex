package view
{
	import control.ToDoModelLocator;
	
	import events.ToDoEvent;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import org.osmf.utils.BinarySearch;
	
	import spark.components.List;
	import spark.components.SkinnableContainer;

	/**
	 * 
	 * @author glava
	 * 
	 */	
	public class ToDoViewComponent extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var mainList:List;
		
		[Inject]
		public var toDoModelLocator:ToDoModelLocator;
		
		public function ToDoViewComponent()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE,onPreinitialize);
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == mainList)
			{
				
			}
		}
		
		public function onPreinitialize(evt:Event):void
		{
			dispatchEvent(new Event("configureView", true));
		
		}
		
		[MessageHandler(type="events.ToDoEvent", selector="All.To.Do.Done")]
		public function onToDoListFetch(evt:ToDoEvent):void
		{
			mainList.dataProvider = toDoModelLocator.toDoList;
		}
	}
}