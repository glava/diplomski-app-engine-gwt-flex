package goran.com.server.gwt.impl;



import javax.servlet.http.HttpServletRequest;

import goran.com.client.gwt.CheckLoginStatus;

import com.google.gwt.user.server.rpc.RemoteServiceServlet;

public class CheckLoginStatusImpl extends RemoteServiceServlet implements CheckLoginStatus{

	@Override
	public Boolean loginStatus()
	{
		HttpServletRequest httpServletRequest = this.getThreadLocalRequest();

		if(httpServletRequest.getUserPrincipal() == null)
		{
			return false;

		}
		else
		{
			return true;
		}
	}
}
