<!--#include file="inc/header.aspx"-->
  <div>
  
    <div style="position:relative;top:140px">
      <span style="font-size:26;color:black">Your Order History With AmpleWears</span>
    </div>

    <p>
      &nbsp;
    </p>

    <p>
      &nbsp;
    </p>

    <%
    String username;

    username = (String) Session["username"];

    String a, b;

    a = Request["a"];

    b = Request["b"];

    if(a == null) {
      a = "1";
      b = "6";
    }

    %>

    <div style = "float:left; width: 50px; height: 30px;position:relative;top:100px">
      <a href='orders.asp?a=<%=Convert.ToInt32(a)-6%>&b=<%=Convert.ToInt32(b)-6%>' style="color:black">less...</a>
    </div>

    <%

    String queryString = "SELECT orderid,price,inputdate FROM   (    SELECT *    FROM   \"order2\" where username = '"+username+"' order by orderid desc) WHERE rownum between "+a+" AND "+b;

    command = new OdbcCommand(queryString, connection);

    OdbcDataReader reader = command.ExecuteReader();

    int count = 0;

    while (reader.Read()) {
      %>
      <div style = "width:100%;float:left;color:black;position:relative;top:100px">
        <div stylef = "width:800px;float:left;position:relative;left:-100px">
          <div style="float:left;width:180px"><a style="color:black" href='orderitems.aspx?orderid=<%=reader.GetString(0)%>'%><%=reader.GetString(0)%></div>
          <div style="float:left;width:120px;color:black">$<%=reader.GetString(1)%> USD</div>
          <div style="color:black">
            <nobr>
              <%=reader.GetString(2)%>
            </nobr>
          </div>
        </div><br>
      </div>
      <%
      count = count + 1;
    }

connection.Close();
%>

      <div style = "float:left; width: 100%; height: 30px;position:relative;top:100px">
        <a href='orders.asp?a=<%=Convert.ToInt32(a)+6%>&b=<%=Convert.ToInt32(b)+6%>' style="color:black">more...</a>
      </div>
    </div>

        <p>
      &nbsp;
    </p>

    <p>
      &nbsp;
    </p>

    <p>
      &nbsp;
    </p>

    <p>
      &nbsp;
    </p>

<!--#include file="inc/footer.inc"-->