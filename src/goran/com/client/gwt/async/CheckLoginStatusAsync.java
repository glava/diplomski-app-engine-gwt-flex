package goran.com.client.gwt.async;

import com.google.gwt.user.client.rpc.AsyncCallback;

public interface CheckLoginStatusAsync {
	void loginStatus(AsyncCallback<Boolean> callback);
}
