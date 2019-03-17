<!--#include file="inc/header.aspx"-->
    <div>
      <span style="font-size:26;color:black">Your <span onclick="window.location.href='orders.asp'"><u>Order History</u></span> With AmpleWears</span>
    </div>

    <p>
      &nbsp;
    </p>

    <p>
      &nbsp;
    </p>

    <div style="width:650px">
    <%
    String orderid;

    orderid = Request["orderid"];

    String a, b;

    a = Request["a"];

    b = Request["b"];

    if(a == null) {
      a = "1";
      b = "6";
    }

    String queryString = "SELECT itemid, price, category, image, discount FROM  (    SELECT a.itemid, p.price, p.category, p.image, p.discount     FROM orderitems2 a INNER JOIN products2 p ON a.itemid = p.itemid WHERE a.orderid="+orderid+") WHERE rownum between "+a+" AND "+b+";";

    Response.Write("<h1>Order ID: " + orderid + "</h1>");
    %>

    <div style = "width:100%;float:left">

    <div style="float:left;width:180px;color:black">item id</div>
    <div style="float:left;width:120px;color:black">price</div>
    <div style="float:left;width:120px;color:black">category</div>
    <div style="float:left;width:120px;color:black">image</div>
    
    </div>
    
    <div style = "width:800px;float:left">
      <span><hr style="color:#f0f0f0"></span>
    </div>
          <div style = "float:left; width: 50px; height: 30px">
      <a href='orderitems.asp?orderid=<%=orderid%>&a=<%=Convert.ToInt32(a)-6%>&b=<%=Convert.ToInt32(b)-6%>' style="color:black">less...</a>
    </div>
    <%

      command = new OdbcCommand(queryString, connection);

      OdbcDataReader reader = command.ExecuteReader();

      int count = 0;

      while (reader.Read()) {
      %>
      <div style = "width:100%;float:left">

      <div style="float:left;width:180px"><a href='items.aspx?itemid=<%=reader.GetString(0)%>' style="color:black"><%=reader.GetString(0)%></a></div>
      <div style="float:left;width:120px;color:black">$<%=reader.GetString(1)%> USD</div>
      <div style="float:left;width:120px;color:black"><%=reader.GetString(2)%></div>
      <div style="float:left;width:120px;color:black"><img src='/productitems/<%=reader.GetString(3)%>'></div>

      </div><br>
      <%
    }
    %>

    </div>
      <div style = "float:left; width: 50px; height: 30px">
      <a href='orderitems.asp?orderid=<%=orderid%>&a=<%=Convert.ToInt32(a)+6%>&b=<%=Convert.ToInt32(b)+6%>' style="color:black">more...</a>
      </div>

  </div>

    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
<%
connection.Close();
%>

<!--#include file="inc/footer.inc"-->