<!--#include file="inc/header.aspx"-->
<style>
    .title {
      font-size: 200%;
      font-stretch: condensed;
      font-weight: bold;
    }
  </style>
  
    <div style="width:1000px;float:left">

    <div style="text-align:left;float:left;font-size:40px;color:white;background-color:gray;position:relative;top:90px;left:-240px;width:760px;height:70px">
      <!--<img src="/graphics/images/shopping-cart-banner.png">-->
      <br>
      &nbsp;YOUR CART
    </div>

    </div>

    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>
    <h1>&nbsp;</h1>

    <div style="width:1200px;float:left;position:relative;left:10px">
    <%
    double total1;
    total1 = 0;

    String itemid;

    itemid = Request["itemid"];

    String cartid;

    String clearcart;

    String queryString;
    queryString = "";

    OdbcDataReader reader;

    double w;
    w = 0;

    cartid = (String) Session["cartid"];

    clearcart = Request["do"];

    if(clearcart != null)
    if(clearcart.Equals("clear")) {

      String query = "DELETE FROM cart2 WHERE cid = " + cartid;

      command = new OdbcCommand(query, connection);

      command.ExecuteNonQuery();
    }

    if(itemid != null)
    if(!itemid.Equals("")) {

      if(cartid == null) {

        String query = "SELECT cid AS id FROM cart2 order by cid desc";

        command = new OdbcCommand(query, connection);

        reader = command.ExecuteReader();

        if(reader.Read()) {
          cartid = (reader.GetInt32(0) + 1) + "";
        } else {
          cartid = "1";
        }

        Session["cartid"] = cartid;
      }

      String query1 = "INSERT INTO cart2 (cid,itemid) VALUES ("+cartid+","+itemid+")";

      command = new OdbcCommand(query1, connection);
      command.ExecuteNonQuery();
    }

    String query2 = "SELECT itemid, cid FROM cart2 WHERE cid = " + cartid;

    command = new OdbcCommand(query2, connection);

    if(cartid == null) {
      reader = null;
    } else {   
      reader = command.ExecuteReader();
    }

   if(cartid != null) {
   %><br><br>
    <div style="float:left;width:590px;height:100%">


<%
    w = 0;
    total1 = 0;
    while(reader.Read()) {
      String iid;
      iid = reader.GetString(0);

      queryString = "SELECT weight, image, name, category, discount, price, dsc FROM products2 WHERE itemid = " + iid;
      
      command = new OdbcCommand(queryString, connection);

      OdbcDataReader reader1 = command.ExecuteReader();

      while(reader1.Read()) {
        %>
    <div style = "width:900px;float:left">
    <div style="float:left;width:60px">image</div>
    <div style="float:left;width:260px">item id</div>
    <div style="float:left;width:110px">category</div>
    <div style="float:left;width:230px">price</div>
    </div>


      <div style = "width:750px;height:170px;border:1px solid gray">

      <div style="float:left;width:60px"><div style="height:40px;width:40px"><img src=/productitems/<%=reader1.GetString(1)%>></div>&nbsp;</div>&nbsp;
      <div style="float:left;width:260px"><a style="color:black" href='items.aspx?itemid=<%=iid%>'><%=reader1.GetString(2)%></a></div>&nbsp;
      <div style="float:left;width:110px"><%=reader1.GetString(3)%></div>&nbsp;
      <div style="float:left;width:230px">$<%=reader1.GetString(5)%>
<br>
<b>Description:</b> <%=reader1.GetString(6)%>...
      </div>

      </div><br>
        <%
        total1 = total1 + Convert.ToDouble(reader1.GetString(5));
        w = w + Convert.ToDouble(reader1.GetDecimal(0));
      }

    }
 
  %>
    </div>
  <%
  }

  if(total1 > 0) {
  %>

<div style="border:10px solid gray;float:left;width:262px;height:300px;position:relative;left:200px;top:-110px">
  <h3>Summary</h3>
<h4 style="color:red">Subtotal: $<%=total1%></h4>
<a href="cart.aspx?do=clear" style="color:#ff0000"><button>Clear cart</button></a>
<script>
  var x = document.getElementById("mi");
  x.innerHTML = '<img src="/graphics/images/shipping.png"><font size=-2>$20 flat fee fore shipping using UPS Ground Shipping method.  Shipping takes usually 1 ~ 6 business days.</font>';
  x.style.display = "block";
</script>
<br><br>
  <form method="post" action="buy.aspx">
    <input type="hidden" name="t" value=<%=total1%>>
    <input type="hidden" name="w" value=<%=w%>>
    <input type="submit" value="Check Out" style="background-color:gray;color:white;font-size:20px;font-weight:bold;width:200px; height:70px">
  </form>

</div>
<%
}

connection.Close();
%>

  </div>