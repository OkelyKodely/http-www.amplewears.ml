<div style="width:230px;text-align:center;position:relative;left:10px;top:10px">
  <div style="width:100%;border:1px solid gray;height:40px">
  <a href="index.aspx" style="color:white;font-size:20px;text-decoration:underlin">
    Home
  </a>
  </div>
  <div style="width:100%;border:1px solid gray;height:40px">
  <a href="about.aspx" style="color:white;font-size:20px;text-decoration:underlin">
    About
  </a>
  </div>
  <div style="width:100%;border:1px solid gray;height:40px">
  <a href="cart.aspx" style="color:white;font-size:20px;text-decoration:underlin">
    Cart
  </a>
  </div>
  <div style="width:100%;border:1px solid gray;height:40px">
      <%
      if(Session["username"] == null) {
      %>
  <a href="signup.aspx" style="color:white;font-size:20px;text-decoration:underlin">
    Register
  </a>
  <%
 } else {
  %>
  <a href="orders.aspx" style="color:white;font-size:20px;text-decoration:underlin">
    Orders
  <%
}
  %>
  </div>
  <div style="width:100%;border:0.05em solid gray;height:40px">
  <a href="contactus.aspx" style="color:white;font-size:20px;text-decoration:underlin">
    Contact Us
  </a>
  </div>
      <%
      if(Session["username"] == null) {
      %>
      <form id="loginFrm" method="post" action="login.aspx">
        <div style="color:white;">
        Username: <br><input type="text" name="username"><br>
        Password: <br><input type="password" name="password">
        <input type="hidden" name="ru" value="index.aspx"><br>
        <button class="favorite styled3" style="width:200px;color:black;" onclick="document.getElementById('loginFrm').submit()">Sign in</button>
        
        <h4>New to AmpleWears? <br><a style="color:gray" href="signup.aspx">Create Account</a></h4>
        <%
        } else {
        %>
        <h3 style="color:gray">Hi, <%=Session["username"]%>.<br> Welcome.</h3>
        <ul style="width:100px;position:relative;left:35px">
        <li><a href="orders.aspx" style="color:gray">Your Orders</a><br></li>
        <li><a href="cart.aspx" style="color:gray">Your Cart</a><br></li>
        <li><a href="logout.aspx" style="color:gray">Sign out</a></li>
      </ul>
        <%
        }
        %>
        </div>
</div>