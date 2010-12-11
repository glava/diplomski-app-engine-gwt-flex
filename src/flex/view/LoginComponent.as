package view
{
	
	import events.LoginEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.ToDoLaUser;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.SkinnableContainer;
	import spark.components.TextInput;
	
	public class LoginComponent extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var txtUserName:TextInput;
	
		[SkinPart(required="true")]
		public var txtPasword:TextInput;
		
		[SkinPart(required="true")]
		public var btnLogIn:Button;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function LoginComponent()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE,onPrinitilize);
		}
		
		public function onPrinitilize(evt:FlexEvent):void
		{
			dispatchEvent(new Event("configureView", true));
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == btnLogIn)
			{
				btnLogIn.addEventListener(MouseEvent.CLICK,onMouseEventClick);
			}
			
		}
		
		public function onMouseEventClick(evt:MouseEvent):void
		{
			var newToDouser:ToDoLaUser = new ToDoLaUser();
			newToDouser.username = txtUserName.text;
			newToDouser.password = txtPasword.text;
			dispatcher(new LoginEvent(LoginEvent.LOGIN_USER,newToDouser,true));
		}
	}
}