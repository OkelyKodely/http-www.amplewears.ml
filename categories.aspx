<!--#include file="inc/header.aspx"-->
<!--<div style="width:263px;height:483px;float:left;position:relative;top:62px;left:-240px;background-color:#333;z-index:0">
<!--#include file="inc/sidemenu.aspx"-->
</div>-->

      <div style="text-align:left;height:60px;position:relative;left:-230px;top:100px;width:100%">
<h1>Shop: <u><%=Request["s"]%>'s <%=Request["cat"]%>&nbsp;<%=Request["cat2"]%></u></h1>
  </div>
<%
  int a, b;
  String s;

  s = Request["s"];

  if(Request["a"] == null) {
    a = 1;
    b = 16;
  } else {
    a = Convert.ToInt32(Request["a"]);
    b = Convert.ToInt32(Request["b"]);
  }

  String queryString = "";

  command = new OdbcCommand(queryString, connection);

  String cat2;

  cat2 = Request["cat2"];

  if(cat2 == null) {

    if(s.Equals("men")) {
      queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2  WHERE category = '"+cat+"' and men = 1) WHERE rownum between "+a+" AND "+b+";";
    } else {
      queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2  WHERE category = '"+cat+"' and women = 1) WHERE rownum between "+a+" AND "+b+";";
    }

  } else {

    if(s.Equals("men")) {
      queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2  WHERE category = '"+cat+"' and category2 = '"+cat2+"' and men = 1) WHERE rownum between "+a+" AND "+b+";";
    } else {
      queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2  WHERE category = '"+cat+"' and category2 = '"+cat2+"' and women = 1) WHERE rownum between "+a+" AND "+b+";";
    }

  }

    int count = 0;

    command = new OdbcCommand(queryString, connection);
    
    OdbcDataReader reader = command.ExecuteReader();

    while(reader.Read()) {

    if(count % 4 == 0) {
    %>
      <div style="text-align:left;height:500px;position:relative;top:100px;width:100%">
    <%
    }
    %>
    <div style = "position:relative;left:0px;float:left; width:300px; height: 600px;color:black">
      <div style="text-align:center">
        <a style="color:black" href='items.asp?itemid=<%=reader.GetString(2)%>'><%=reader.GetString(3)%></a><br>
      </div>
      <div style="text-align:center">
        <a href='items.aspx?itemid=<%=reader.GetString(2)%>' style="color:black"><form method="post" action="cart.aspx"><input type="hidden" name="itemid" value=<%=reader.GetString(2)%>><img src="/graphics/images/view.png" onmouseover="this.src='/graphics/images/view-mo.png'" onmouseout="this.src='/graphics/images/view.png'"><br><input type="image" src="/graphics/images/ad.png" onmouseover="this.src='/graphics/images/ad-mo.png'" onmouseout="this.src='/graphics/images/ad.png'" border="0" value="" name="submit"></form><img src='/productitems/<%=reader.GetString(0)%>' width="200" height="230"></a><br><br>
                <a href='items.aspx?itemid=<%=reader.GetString(2)%>'><font color="#cc0000" size="4">Price: $<%=reader.GetString(4)%></font></a><br>
      </div>
    </div>
    <%
    if(count % 4 == 3) {
    %>
      </div>
    <%
    }
    %>
<%
  count = count + 1;
}

connection.Close();
    %>
<div style="height:700px;width:100%">&nbsp;</div>
<!--#include file="inc/footer.inc"-->