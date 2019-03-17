<!--#include file="inc/header.aspx"-->
<div style="width:263px;height:391px;float:left;position:relative;top:62px;left:-240px;background-color:#333;">
<!--#include file="inc/sidemenu.aspx"-->
</div>
<div id="one" style="display:none;float:left;position:relative;top:-333px;left:263px;text-align:center;width:1000px">
  <img src="/graphics/images/blowout80per.jpg">
</div>

<div id="two" style="position:relative;top:-333px;left:263px;float:left;text-align:center;width:1000px">
  <img src="/graphics/images/blowout80per2.png">
</div>

    <div id="thisiswomen" style="text-align:center;position:absolute;top:521px;left:0px;width:100%;height:60px;background-color:#000000;color:white">
    <h1>Shop Below</h1>
    <h1 style="color:black">Featured</h1>
    
<%
  String queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2 where women = 1 and featured = 1    ORDER BY DBMS_RANDOM.VALUE) where rownum between 1 and 4;";

  command = new OdbcCommand(queryString, connection);

  OdbcDataReader reader = command.ExecuteReader();

    int count = 0;

while (reader.Read()) {
    if(count < 4) {
    %>
    <div style = "float:left; width: 300px; height: 480px;color:black">
      <div style="text-align:center">
        <a style="color:black" href='items.aspx?itemid=<%=reader.GetString(2)%>'><%=reader.GetString(3)%></a><br>
      </div>
      <div style="text-align:center">
        <a href='items.aspx?itemid=<%=reader.GetString(2)%>' style="color:black"><nobr><form method="post" action="cart.aspx"><input type="hidden" name="itemid" value=<%=reader.GetString(2)%>><img src="/graphics/images/view.png" onmouseover="this.src='/graphics/images/view-mo.png'" onmouseout="this.src='/graphics/images/view.png'"><input type="image" src="/graphics/images/ad.png" onmouseover="this.src='/graphics/images/ad-mo.png'" onmouseout="this.src='/graphics/images/ad.png'" border="0" value="" name="submit"></form></nobr><br><img src='/productitems/<%=reader.GetString(0)%>' width="80" height="230"></a><br>
                <a href='items.aspx?itemid=<%=reader.GetString(2)%>'><font color="red" size="4">On Sale: $<%=reader.GetString(4)%></font></a><br>
      </div>
    </div>

<%
      }
      count = count + 1;
    }
%>
</div>
    <div id="thisismen" style="display:none;text-align:center;position:absolute;top:521px;left:0px;width:100%;height:60px;background-color:#000000;color:white">
    <h1>Shop Below</h1>
    <h1 style="color:black">Featured</h1>
    
<%
  queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2 where men = 1 and featured = 1    ORDER BY DBMS_RANDOM.VALUE) where rownum between 1 and 4;";

command = new OdbcCommand(queryString, connection);
reader = command.ExecuteReader();

    count = 0;

while (reader.Read()) {
    if(count < 4) {
    %>
    <div style = "float:left; width: 300px; height: 480px;color:black">
      <div style="text-align:center">
        <a style="color:black" href='items.aspx?itemid=<%=reader.GetString(2)%>'><%=reader.GetString(3)%></a><br>
      </div>
      <div style="text-align:center">
        <a href='items.aspx?itemid=<%=reader.GetString(2)%>' style="color:black"><nobr><form method="post" action="cart.aspx"><input type="hidden" name="itemid" value=<%=reader.GetString(2)%>><img src="/graphics/images/view.png" onmouseover="this.src='/graphics/images/view-mo.png'" onmouseout="this.src='/graphics/images/view.png'"><input type="image" src="/graphics/images/ad.png" onmouseover="this.src='/graphics/images/ad-mo.png'" onmouseout="this.src='/graphics/images/ad.png'" border="0" value="" name="submit"></form></nobr><br><img src='/productitems/<%=reader.GetString(0)%>' width="80" height="230"></a><br>
                <a href='items.aspx?itemid=<%=reader.GetString(2)%>'><font color="#cc0000" size="4">Price: $<%=reader.GetString(4)%></font></a><br>
      </div>
    </div>

<%
      }
      count = count + 1;
    }
%>
</div>
<div id="womenw" style="float:left;width:100%;z-index:100;position:relative;top:50px">
<%
  queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2 where women = 1 and featured is null   ORDER BY DBMS_RANDOM.VALUE);";

  command = new OdbcCommand(queryString, connection);

  reader = command.ExecuteReader();

    count = 0;

    bool f = false;

while (reader.Read()) {
    if(count % 4 == 0) {
    %>
      <div style="float:left;width:100%;height:350px">
    <%
    }
    %>
    <div style = "float:left; width: 300px; height: 350px;color:black">
      <div style="text-align:center">
        <a style="color:black" href='items.aspxx?itemid=<%=reader.GetString(2)%>'><%=reader.GetString(3)%></a><br>
      </div>
      <div style="text-align:center">
        <a href='items.aspx?itemid=<%=reader.GetString(2)%>' style="color:black"><nobr><form method="post" action="cart.aspx"><input type="hidden" name="itemid" value=<%=reader.GetString(2)%>><img src="/graphics/images/view.png" onmouseover="this.src='/graphics/images/view-mo.png'" onmouseout="this.src='/graphics/images/view.png'"><input type="image" src="/graphics/images/ad.png" onmouseover="this.src='/graphics/images/ad-mo.png'" onmouseout="this.src='/graphics/images/ad.png'" border="0" value="" name="submit"></form></nobr><img src='/productitems/<%=reader.GetString(0)%>' width="120" height="180"></a><br><br>
                <a href='items.aspx?itemid=<%=reader.GetString(2)%>'><font color="#cc0000" size="4">Price: $<%=reader.GetString(4)%></font></a><br>
      </div>
    </div>
    <%
    if(count % 4 == 3) {
    %>
      </div>
    <%
      f = true;
    } else {
      f = false;
    }
    %>
<%
  count = count + 1;
}

if(!f) {
%>
</div>
<%
}
    %>
</div>
<div id="notWomen" style="display:none;float:left;width:100%;z-index:101;position:relative;top:50px">
<%
  queryString = "SELECT image, discount, itemid, name, price FROM   (    SELECT *    FROM   products2 where men = 1 and women is null and men is not null and featured is null   ORDER BY DBMS_RANDOM.VALUE);";

  command = new OdbcCommand(queryString, connection);

  reader = command.ExecuteReader();

    count = 0;

    f = false;

while (reader.Read()) {
    if(count % 4 == 0) {
    %>
      <div style = "float:left;width:100%;height:350px">
    <%
    }
    %>
    <div style = "float:left; width: 300px; height: 350px;color:black">
      <div style="text-align:center">
        <a style="color:black" href='items.aspxx?itemid=<%=reader.GetString(2)%>'><%=reader.GetString(3)%></a><br>
      </div>
      <div style="text-align:center">
        <a href='items.aspx?itemid=<%=reader.GetString(2)%>' style="color:black"><nobr><form method="post" action="cart.aspx"><input type="hidden" name="itemid" value=<%=reader.GetString(2)%>><img src="/graphics/images/view.png" onmouseover="this.src='/graphics/images/view-mo.png'" onmouseout="this.src='/graphics/images/view.png'"><input type="image" src="/graphics/images/ad.png" onmouseover="this.src='/graphics/images/ad-mo.png'" onmouseout="this.src='/graphics/images/ad.png'" border="0" value="" name="submit"></form></nobr><img src='/productitems/<%=reader.GetString(0)%>' width="120" height="180"></a><br><br>
                <a href='items.aspx?itemid=<%=reader.GetString(2)%>'><font color="#cc0000" size="4">Price: $<%=reader.GetString(4)%></font></a><br>
      </div>
    </div>
    <%
    if(count % 4 == 3) {
    %>
      </div>
    <%
      f = true;
    } else {
      f = false;
    }
    %>
<%
  count = count + 1;
}

if(!f) {
%>
</div>
<%
}

    %>
  </div>
    <%
connection.Close();
%>
<h1>&nbsp;</h1>
<!--#include file="inc/footer.inc"-->