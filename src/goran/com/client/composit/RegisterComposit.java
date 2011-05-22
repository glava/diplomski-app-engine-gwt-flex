package goran.com.client.composit;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.CheckBox;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.FlexTable;
import com.google.gwt.user.client.ui.TextBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Label;

public class RegisterComposit extends Composite {
	private Button signInButton;
	private CheckBox rememberMeOnCheckBox;
	private TextBox textBoxPassword;
	private TextBox textBoxUsername;
	private Label passwordLabel;
	private Label usernameLabel;
	private FlexTable flexTable;
	private Label signInToLabel;
	private VerticalPanel verticalPanel;
	
	public RegisterComposit() {
		

		verticalPanel = new VerticalPanel();
		initWidget(verticalPanel);

		signInToLabel = new Label("Sign in to your account.");
		verticalPanel.add(signInToLabel);

		flexTable = new FlexTable();
		verticalPanel.add(flexTable);

		usernameLabel = new Label("Username:");
		flexTable.setWidget(0, 0, usernameLabel);

		passwordLabel = new Label("Password:");
		flexTable.setWidget(1, 0, passwordLabel);

		textBoxUsername = new TextBox();
		flexTable.setWidget(0, 1, textBoxUsername);

		textBoxPassword = new TextBox();
		flexTable.setWidget(1, 1, textBoxPassword);

		rememberMeOnCheckBox = new CheckBox();
		flexTable.setWidget(2, 1, rememberMeOnCheckBox);
		rememberMeOnCheckBox.setText("Remember me on this computer.");

		signInButton = new Button();
		flexTable.setWidget(3, 1, signInButton);
		signInButton.addClickHandler(new ClickHandler() {
			
			@Override
			public void onClick(ClickEvent event) {
				// TODO Auto-generated method stub
				
			}
		});
		signInButton.setText("Sign In");
	}

}
