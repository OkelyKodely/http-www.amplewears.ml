<!--#include file="inc/header.aspx"-->
  <div style="position:relative;top:100px">
  
    <div class="shoptitle">
      <span style="font-size:26">Your Search Results</span>
    </div>

    <div style="width:650px">
    <%
    String query;

    query = Request["search"];

    query = query.Replace(" ", "%");

    String a, b;

    a = Request["a"];

    b = Request["b"];

    if(a == null) {
      a = "1";
      b = "6";
    }

  String queryString = "SELECT itemid,image,price,name,category,dsc FROM   (    SELECT *    FROM   products2 where name like '%"+query+"%') WHERE rownum between "+a+" AND "+b+";";

  command = new OdbcCommand(queryString, connection);

OdbcDataReader reader = command.ExecuteReader();

    %>
    
<Br><br>

    <div style = "width:100%;">

    <div style="float:left;width:840px">Results for: <%=query%><hr style="width:1200px">
</div>
    </div>
      <%
      int count;

      count = 0;

while (reader.Read() && query != null) {

    if(count == 0) {
    %>
      <div stylef = "width:800px;float:left;position:relative;left:-100px">
      <div style = "float:left; width: 50px; height: 30px">
      <a href='shopresults.asp?query=<%=query%>&a=<%=Convert.ToInt32(a)-6%>&b=<%=Convert.ToInt32(b)-6%>'>less...</a>
    </div>
    <%
    }

      %>
      <div style = "width:1000px;float:left">

      <div style="width:220px"><%=reader.GetString(0)%> &nbsp;&nbsp;&nbsp;&nbsp;<a href='items.aspx?itemid=<%=reader.GetString(0)%>' style="color:red"><%=reader.GetString(3)%></a></div>
      <div style="width:220px">$<%=reader.GetDecimal(2)+""%> USD</div>
      <div style="width:220px">Category: <%=reader.GetString(4)%></div>
      <div style="width:220px"><img src='/productitems/<%=reader.GetString(1)%>'></div>
      <div style="width:100%">Description: <%=reader.GetString(5)%></div>

      </div>

      <h1>&nbsp;</h1>
      <%
      count = count + 1;
    }

connection.Close();
%>
<!--#include file="inc/footer.inc"-->