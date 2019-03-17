<%@ Page Language="C#" Debug="true" %>
<%
Session.Clear();
Session.Abandon();
Response.Redirect("login.aspx",true);
%>