package view
{
	
	import control.LogoutCommand;
	import control.ToDoModelLocator;
	
	import events.AuthenticateUserEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.ToDoLaUser;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	import mx.logging.Log;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import spark.components.TextInput;
	
	public class LoginComponent extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var txtUserName:TextInput;
		
		[SkinPart(required="true")]
		public var lblUsername:Label;
		[SkinPart(required="true")]
		public var lblLogOut:Label;
	
		[SkinPart(required="true")]
		public var txtPasword:TextInput;
		
		[SkinPart(required="true")]
		public var btnLogIn:Button;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var toDoModel:ToDoModelLocator;
		private var viewState:String = "normal";
		public function LoginComponent()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE,onPrinitilize);
		}
		
		public function onPrinitilize(evt:FlexEvent):void
		{
			dispatchEvent(new Event("configureView", true));
			
		}
		
		[Init]
		public function init():void
		{
			BindingUtils.bindSetter(onUserChange,toDoModel,"currentUser");
		}		
	
		override protected function getCurrentSkinState():String
		{
			return viewState;
		}
		
		public function onUserChange(value:ToDoLaUser):void
		{
			if(value!=null)
			{
				viewState = "logedIn";
				invalidateSkinState();
				
			}
			else
			{
				viewState = "loggedOut";
				invalidateSkinState();
			}
			
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == btnLogIn)
			{
				btnLogIn.addEventListener(MouseEvent.CLICK,onMouseEventClick);
			}
			if(instance == lblUsername)
			{
				if(toDoModel.currentUser != null)
				{
					lblUsername.text = toDoModel.currentUser.username;
				}
			}
			if(instance == lblLogOut)
			{
				lblLogOut.addEventListener(MouseEvent.CLICK,onLblClick);
			}
			
		}
		public function onLblClick(evt:MouseEvent):void
		{
			dispatcher(new AuthenticateUserEvent(AuthenticateUserEvent.LOGOUT_USER,toDoModel.currentUser));
		}
		public function onMouseEventClick(evt:MouseEvent):void
		{
			var newToDouser:ToDoLaUser = new ToDoLaUser();
			newToDouser.username = txtUserName.text;
			newToDouser.password = txtPasword.text;
			dispatcher(new AuthenticateUserEvent(AuthenticateUserEvent.LOGIN_USER,newToDouser,true));
		}
	}
}