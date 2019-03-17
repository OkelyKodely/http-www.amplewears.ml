<!--#include file="inc/header.aspx"-->
<%
  String username;
  String password;

  if(Session["username"] == null) {

    username = Request["username"];
    password = Request["password"];

  } else {

    username = (String) Session["username"];
    password = (String) Session["password"];

  }

  %>
  <div class="login" style="float:left; width:100%; height:700px;text-align:center">
  <h1 style="position:relative;left:0px;top:100px">Returning Customer - Sign in</h1>
  <%
  if(username == null) {
  %>
      <div style="width:400px;height:600px;background-image:url('/graphics/images/loginbg.png');background-repeat:no-repeat;background-attached:fixed;background-position:center;">
        <div>

    <div style="text-align:center;position:relative;left:350px;top:100px;z-index:2">
    <div style="height:70px;position:relative;top:0px">
    </div>
          <form method="post" action="">
            <div style="float:left;width:90px">Username:</div>
            <div style="loat:left"><input type="text" name="username"></div>
            <span><br></span>
            <div style="float:left;width:90px">Password:</div>
            <div style="loat:left"><input type="password" name="password"></div>
            <input type="submit" value="Sign in" style="top:30px;width:140px;height:40px;position:relative;left:0px">
          </form>
        </div>
      </div>
    </div>

      <div style="width:400px;height:600px;ackground-image:url('/graphics/images/loginbg.png');background-repeat:no-repeat;background-attached:fixed;background-position:center;position:relative;">
        <div>

    <div style="position:relative;left:330px;top:-250px;z-index:2">
    <div style="height:70px;position:relative;top:0px">
    </div>
    <p style="color:black">Don't have an account with us?</p>
    <a href="signup.asp"><h1 style="color:black">Create Account</h1></a>
        </div>
      </div>
    </div>

<%
} else {

  String queryString = "SELECT username FROM shoppers2 WHERE username='"+username+"' AND password='"+password+"'";

  command = new OdbcCommand(queryString, connection);

OdbcDataReader reader = command.ExecuteReader();

if(reader.Read()) {
  Session["username"] = reader.GetString(0);
%><br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=reader.GetString(0)%> logged on.  Thanks.
<%
    String ru;
    ru = Request["ru"];
    if(ru != null) {
      Response.Redirect(ru, false);
    }
  } else {
    if(Session["username"] != null) {
      Response.Write("not logged on");
    }
  }
}

connection.Close();
%>
  </div>

<!--#include file="inc/footer.inc"-->