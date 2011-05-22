package view
{
	import control.ToDoModelLocator;
	
	import events.CreateToDoEvent;
	import events.MailEvent;
	import events.ToDoEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.DataGrid;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.List;
	import spark.components.SkinnableContainer;
	
	import util.ParsleyPopUpManager;
	
	import view.components.AuthPopUpWindow;
	import view.components.MailPopUpComponent;
	import view.irenderer.ToDoItemRenderer;

	/**
	 * 
	 * @author glava
	 * 
	 */	
	public class ToDoViewComponent extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var mainList:List;
		[SkinPart(required="true")]
		public var doneList:List;
		
		[SkinPart(required="true")]
		public var btnSort:Button;
		[Inject]
		public var parsleyPopUpManager:ParsleyPopUpManager;
		
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
			if(instance == btnSort)
			{
				btnSort.addEventListener(MouseEvent.CLICK,onSortClick);
			}
			if(instance == mainList)
			{
				addEventListener("toDoRendererSendMail",onSendMailClicked);
				addEventListener("toDoRendererChange",onRendererChange);
				addEventListener("toDoRenderDelete",onDeleteToDo);
			}
		}
		
		public function onMouseClick(evt:Event):void
		{
			PopUpManager.centerPopUp(new AuthPopUpWindow);
		}
		public function onSendMailClicked(evt:Event):void
		{
			toDoModelLocator.currentToDo = (evt.target as ToDoItemRenderer).toDo;
			parsleyPopUpManager.showAndCenterPopUp(MailPopUpComponent);
		}
		public function onDeleteToDo(evt:Event):void
		{
			dispatcher(new CreateToDoEvent(CreateToDoEvent.DELETE_TO_DO,(evt.target as ToDoItemRenderer).toDo));
		}
		public function onRendererChange(evt:Event):void
		{
			dispatcher(new CreateToDoEvent(CreateToDoEvent.UPDATE_TO_DO,(evt.target as ToDoItemRenderer).toDo));
		}
		
		public function onPreinitialize(evt:Event):void
		{
			dispatchEvent(new Event("configureView", true));
		
		}
		
		[MessageHandler(type="events.ToDoEvent", selector="All.To.Do.Done")]
		public function onToDoListFetch(evt:ToDoEvent):void
		{
			mainList.dataProvider = toDoModelLocator.toDoList;
			doneList.dataProvider = toDoModelLocator.doneList;
		}
		
		public function onReverse():void
		{
			toDoModelLocator.toDoList = new ArrayCollection(toDoModelLocator.toDoList.toArray().reverse());
			toDoModelLocator.toDoList.refresh();
		}
		public var reverse:Boolean;
		public function onSortClick(evt:MouseEvent):void
		{
			/* Create the SortField object for the "data" field in the ArrayCollection object, and make sure we do a numeric sort. */
			sort();
			
		}
		
		public function sort():void
		{
			var dataSortField:SortField = new SortField();
			dataSortField.name = "priority";
			dataSortField.numeric = true;
			dataSortField.descending = reverse;
			
			/* Create the Sort object and add the SortField object created earlier to the array of fields to sort on. */
			var numericDataSort:Sort = new Sort();
			numericDataSort.reverse();
			numericDataSort.fields = [dataSortField];
			
			/* Set the ArrayCollection object's sort property to our custom sort, and refresh the ArrayCollection. */
			toDoModelLocator.toDoList.sort = numericDataSort;
			toDoModelLocator.toDoList.refresh();
			reverse = !(reverse);
			
		}
		
	}
}