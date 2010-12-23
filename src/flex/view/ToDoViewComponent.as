package view
{
	import control.ToDoModelLocator;
	import events.MailEvent;
	import events.ToDoEvent;
	import flash.events.Event;
	import mx.events.FlexEvent;
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
		[MessageDispatcher]
		public var dispatcher:Function;
		
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
				addEventListener("onIRSendMail",onSendMailClicked);
			}
		}
		
		public function onSendMailClicked(evt:Event):void
		{
			dispatcher(new MailEvent(MailEvent.SEND_HELP_MAIL,true));
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