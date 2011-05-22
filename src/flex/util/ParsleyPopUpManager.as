package util
{

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventPhase;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.effects.Pause;
	import mx.effects.Sequence;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	
	import org.spicefactory.parsley.core.context.Context;
	
	import spark.effects.Fade;

	/**
	 *
	 * @author bdjuricic
	 */
	public class ParsleyPopUpManager
	{


		[Inject]
		/**
		 *
		 * @default
		 */
		public var context:Context;

		private var centeredPopups:ArrayCollection;

		/**
		 *
		 * @param windowComponent
		 * @param modal
		 * @return
		 */
		public function showPopUp(windowComponent:Class, modal:Boolean=false,newContext:Context = null):IFlexDisplayObject
		{
			try
			{
				var window:IFlexDisplayObject=IFlexDisplayObject(new windowComponent())
				// set properties
				
				if(newContext == null)
				{
					context.viewManager.addViewRoot(DisplayObject(window));
					
				}
				else
				{
					newContext.viewManager.addViewRoot(DisplayObject(window));
				}

				PopUpManager.addPopUp(window, DisplayObject(FlexGlobals.topLevelApplication), modal);
				return window;
			}
			catch (err:Error)
			{
				return null;
			}
			return null;
		}
		

		/**
		 * Add window to list of centered popups
		 * @param window
		 * @author inajman
		 *
		 */
		private function addCenterPopup(window:IFlexDisplayObject):void
		{
			if (centeredPopups == null)
			{
				centeredPopups=new ArrayCollection();
			}

			centeredPopups.addItem(window);
		}

		/**
		 *
		 * @param windowComponent
		 * @param modal
		 * @return
		 */
		public function showAndCenterPopUp(windowComponent:Class, modal:Boolean=false,newContext:Context = null):IFlexDisplayObject
		{
			var window:IFlexDisplayObject=this.showPopUp(windowComponent, modal,newContext)
			if (window == null)
			{
				return null;
			}
			if(window is UIComponent)
			{
				FlexGlobals.topLevelApplication.callLater(focusOnOpenedWindow, [window as UIComponent]);
			}
			window.stage.addEventListener(Event.RESIZE, window_onResize);
			window.addEventListener(Event.REMOVED_FROM_STAGE, window_onRemovedFromStage);
			PopUpManager.centerPopUp(window);

			//add window to list of all centered popups
			addCenterPopup(window);

			return window;
		}
		
		
		/**
		 * Set focus on passed window component
		 *  
		 * @param window
		 * 
		 */		
		private function focusOnOpenedWindow(window:UIComponent):void{
			window.setFocus();
		}

		/**
		 * When popup is removed from stage this event is triggered, if it was centered before
		 * it will remove the window from the centered popup list and also remove listeners for resize and removed from stage
		 * @param event
		 *
		 */
		private function window_onRemovedFromStage(event:Event):void
		{
			if (event.eventPhase == EventPhase.AT_TARGET)
			{
				var index:int=centeredPopups.getItemIndex(event.target);

				if (index != -1)
				{
					centeredPopups.removeItemAt(index);
				}

				IFlexDisplayObject(event.target).removeEventListener(Event.RESIZE, window_onResize);
				IFlexDisplayObject(event.target).removeEventListener(Event.REMOVED_FROM_STAGE, window_onRemovedFromStage);
			}
		}

		/**
		 * Iterates through all centered popups and center it based upon the stage width/height
		 * @param event
		 *
		 */
		private function window_onResize(event:Event):void
		{
			for each (var item:IFlexDisplayObject in centeredPopups)
			{
				item.x=Stage(event.target).stageWidth / 2 - item.width / 2;
				item.y=Stage(event.target).stageHeight / 2 - item.height / 2;
			}
		}

	}
}