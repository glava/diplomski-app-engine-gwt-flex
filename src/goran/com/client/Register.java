package goran.com.client;


import goran.com.client.gwt.CheckLoginStatus;
import goran.com.client.gwt.async.CheckLoginStatusAsync;
import goran.com.server.gwt.impl.CheckLoginStatusImpl;
import goran.com.shared.FieldVerifier;

import com.google.gwt.user.client.Window; 
import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.KeyCodes;
import com.google.gwt.event.dom.client.KeyUpEvent;
import com.google.gwt.event.dom.client.KeyUpHandler;
import com.google.gwt.user.client.rpc.AsyncCallback;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.DialogBox;
import com.google.gwt.user.client.ui.HTML;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.PasswordTextBox;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.TextBox;
import com.google.gwt.user.client.ui.VerticalPanel;


public class Register implements EntryPoint {
	private static final String SERVER_ERROR = "An error occurred while "
		+ "attempting to contact the server. Please check your network "
		+ "connection and try again.";
	private final GreetingServiceAsync greetingService = GWT
	.create(GreetingService.class);
	private final LoginServiceAsync authUserService = GWT
	.create(LoginService.class);
	private Button sendButton;
	private Button loginSwitchButton;
	private Boolean loginSwitchFlag = false;
	
	/**
	 * This is the entry point method.
	 */
	public void onModuleLoad() {
		sendButton = new Button("Registruj se");
		loginSwitchButton = new Button("Imate nalog?");
		final TextBox nameField = new TextBox();
		final PasswordTextBox passwordField = new PasswordTextBox();
		
		final Label errorLabel = new Label();

		// We can add style names to widgets
		sendButton.addStyleName("sendButton");

		// Add the nameField and sendButton to the RootPanel
		// Use RootPanel.get() to get the entire body element
		RootPanel.get("nameFieldContainer").add(nameField);
		RootPanel.get("passwordFieldContainer").add(passwordField);
		RootPanel.get("sendButtonContainer").add(sendButton);
		RootPanel.get("errorLabelContainer").add(errorLabel);
		RootPanel.get("loginSwitcher").add(loginSwitchButton);

		// Focus the cursor on the name field when the app loads
		nameField.setFocus(true);
		nameField.selectAll();
		
		// Create the popup dialog box
		final DialogBox dialogBox = new DialogBox();
		dialogBox.setText("Remote Procedure Call");
		dialogBox.setAnimationEnabled(true);
		final Button closeButton = new Button("Close");
		// We can set the id of a widget by accessing its Element
		closeButton.getElement().setId("closeButton");
		final Label textToServerLabel = new Label();
		final HTML serverResponseLabel = new HTML();
		VerticalPanel dialogVPanel = new VerticalPanel();
		dialogVPanel.addStyleName("dialogVPanel");
		dialogVPanel.add(new HTML("<b>Welcome!</b>"));
		dialogVPanel.add(textToServerLabel);
		dialogVPanel.add(new HTML("<br><b><a href='ToDoLaa.html'></a></b>"));
		dialogVPanel.add(serverResponseLabel);
		dialogVPanel.setHorizontalAlignment(VerticalPanel.ALIGN_RIGHT);
		dialogVPanel.add(closeButton);
		dialogBox.setWidget(dialogVPanel);

		// Add a handler to close the DialogBox
		closeButton.addClickHandler(new ClickHandler() {
			public void onClick(ClickEvent event) {
				dialogBox.hide();
				sendButton.setEnabled(true);
				sendButton.setFocus(true);
			}
		});
		
		loginSwitchButton.addClickHandler(new ClickHandler() {
			
			@Override
			public void onClick(ClickEvent event) {
				
				loginSwitchFlag = !loginSwitchFlag;
				changeButtonLabel(loginSwitchFlag);
			}

		
		});
		
		// Create a handler for the sendButton and nameField
		class MyHandler implements ClickHandler, KeyUpHandler {
			/**
			 * Fired when the user clicks on the sendButton.
			 */
			public void onClick(ClickEvent event) {
//				sendNameToServer();
				register();
			}

			/**
			 * Fired when the user types in the nameField.
			 */
			public void onKeyUp(KeyUpEvent event) {
				if (event.getNativeKeyCode() == KeyCodes.KEY_ENTER) {
//					sendNameToServer();
					register();
				}
			}
			
			/**
			 * for checking if user is in session
			 */
			private void checkLoginStatus()
			{
				authUserService.checkLoginStatus(new AsyncCallback<Boolean>() {

					@Override
					public void onFailure(Throwable caught) {
						// TODO Auto-generated method stub
						nameField.setText("nije uspeo");
					}

					@Override
					public void onSuccess(Boolean result) {
						// TODO Auto-generated method stub
						if(result)
						{
							nameField.setText("uspeo je");
						}
						else
						{
							nameField.setText("nije uspeo");
						}
					}
				});
			}
			private void login()
			{
				errorLabel.setText("");
				//VERIFY
				String textToServer = nameField.getText();
				if (!FieldVerifier.isValidName(textToServer)) {
					errorLabel.setText("Please enter at least four characters");
					return;
				}
				
				sendButton.setEnabled(false);
				textToServerLabel.setText(textToServer);
				serverResponseLabel.setText("");
				
				authUserService.login(nameField.getText(), passwordField.getText(), new AsyncCallback<Boolean>() {
					public void onFailure(Throwable caught) {
						// Show the RPC error message to the user
						dialogBox
								.setText("Remote Procedure Call - Failure");
						serverResponseLabel
								.addStyleName("serverResponseLabelError");
						serverResponseLabel.setHTML(SERVER_ERROR);
						dialogBox.center();
						closeButton.setFocus(true);
					}

					public void onSuccess(Boolean result) {
						
						if(result)
						{
							  redirect("ToDoLaa.html"); 
						}
						else
						{
						dialogBox.setText("");
						serverResponseLabel
								.removeStyleName("serverResponseLabelError");
						serverResponseLabel.setHTML("Failed registration, contact administrator");
						}
						dialogBox.center();
						closeButton.setFocus(true);
						
					}
				});
			}
		

			protected void redirect(String string) {
				 Window.open("http://127.0.0.1:8888/ToDoLaa.html", "_self", ""); 
				
			}

			private void register(){
				
				if(loginSwitchFlag)
				{
					login();
					return;
				}
				
				errorLabel.setText("");
				//VERIFY
				String textToServer = nameField.getText();
				if (!FieldVerifier.isValidName(textToServer)) {
					errorLabel.setText("Please enter at least four characters");
					return;
				}
				
				sendButton.setEnabled(false);
				textToServerLabel.setText(textToServer);
				serverResponseLabel.setText("");
				
				authUserService.register(nameField.getText(), passwordField.getText(), new AsyncCallback<Boolean>() {
					public void onFailure(Throwable caught) {
						// Show the RPC error message to the user
						dialogBox
								.setText("Remote Procedure Call - Failure");
						serverResponseLabel
								.addStyleName("serverResponseLabelError");
						serverResponseLabel.setHTML(SERVER_ERROR);
						dialogBox.center();
						closeButton.setFocus(true);
					}

					public void onSuccess(Boolean result) {
						
						if(result)
						{
						serverResponseLabel
								.removeStyleName("serverResponseLabelError");
						serverResponseLabel.setHTML("<br><b><a href='ToDoLaa.html'>Fire up the application</a></b>");
						dialogBox.center();
						closeButton.setFocus(true);
						}
						else
						{
						dialogBox.setText("");
						serverResponseLabel
								.removeStyleName("serverResponseLabelError");
						serverResponseLabel.setHTML("Failed registration, contact administrator");
						}
						dialogBox.center();
						closeButton.setFocus(true);
						
					}
				});
			}

		}

		// Add a handler to send the name to the server
		MyHandler handler = new MyHandler();
		sendButton.addClickHandler(handler);
		nameField.addKeyUpHandler(handler);
	}

	protected void changeButtonLabel(Boolean loginSwitchFlag2) {
		if(loginSwitchFlag)
		{
			sendButton.setText("Prijavi se");
			loginSwitchButton.setText("Nemate nalog?");
		}
		else
		{
			sendButton.setText("Registruj se");
			loginSwitchButton.setText("Imate nalog?");
		}
		
	}

}
