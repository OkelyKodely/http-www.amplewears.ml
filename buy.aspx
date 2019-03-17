<!--#include file="inc/header.aspx"-->
  <h1>&nbsp;</h1>
  <h1 style="position:relative;left:0px;top:0px">Checkout</h1>

  <a href="cart.aspx" style="color:gray"><h3 style="position:relative;left:0px;top:0px;">View Your Cart</h3></a>

  <div class="shop">
  
    <div class="shoptitle" style="position:relative;top:0px">
      <span style="font-size:23">Please Enter Your Credit Card & Shipping Information</span><br><br>
    </div>

    <div class="shoptitle" style="position:relative;top:0px" id="steps">
      <img src="/graphics/images/step1.png"><br><br>
    </div>

    <%
    String cartid;

    cartid = (String) Session["cartid"];

    if(cartid == null) {
      Response.Write("error");
    }

    String username;

    username = (String) Session["username"];

    String t;
    String w;

    t = Request["t"];
    w = Request["w"];

    if(username == null) {
      Response.Redirect("/login.aspx?ru=buy.aspx?t=" + t + "&w=" + w, false);
    }
    %>

  <div id = "container" style = "width:100%;position:relative;top:0px">
      <div id = "middle" style = "float:left; width: 200;">
        Subtotal: $<%=t%><br>
        <div id="sh"></div>
        <script>
        function setShippingCost() {
          var x = document.getElementById("shipping").value;
            x = x.split("$");
            var v;
            v = 0;
            v = x[1];
            v = parseFloat(v,10);
            v = v + <%=t%>;
            v = v.toFixed(2);
            document.getElementById("sh").innerHTML = "Shipping: $" + x[1] + "<br>";
            document.getElementById("sh").innerHTML += "<font color='red' size='5'>Total: $" + v + "</font><br>";
        }
        </script>
      </div>
      <div id = "right" style = "float:left; width: 1250;">
        <form method="POST" action="relayresponse.aspx"> 
          <div style="float:left;width:400">
          <h3>Shipping</h3>
<%

String zip;

zip = Request["zip"];

if(zip != null) {
  if(w == null) {
    w = "1";
  }

  UPSShipping.UPS shs1 = new UPSShipping.UPS("9D5A1C57FAB32998", "dhcho428", "Coppersink21", "745VE8", "01");

 Response.Write("Shipping Method: <select id=\"shipping\" name=\"shipping\" onchange=\"setShippingCost()\">");

 Response.Write("<option>UPS Next day Air - $"+shs1.GetRate("1", "90006", "US", "90006", "US", "01")+"</option>");
 Response.Write("<option>UPS Second day Air - $"+shs1.GetRate("1", "90006", "US", "90006", "US", "02")+"</option>");
 Response.Write("<option>UPS Ground - $"+shs1.GetRate("1", "90006", "US", "90006", "US", "03")+"</option>");
 Response.Write("<option>Three-Day Select - $"+shs1.GetRate("1", "90006", "US", "90006", "US", "12")+"</option>");
 Response.Write("<option>Next Day Air Saver - $"+shs1.GetRate("1", "90006", "US", "90006", "US", "13")+"</option>");
 Response.Write("<option>UPS Next Day Air Early AM - $"+shs1.GetRate("1", "90006", "US", "90006", "US", "14")+"</option>");

 Response.Write("</select>");

/*
UPS Next day Air => 01
UPS Second day Air => 02
UPS Ground => 03
Worldwide Express => 07
UPS Worldwide Expedited => 08
UPS Standard => 11
Three-Day Select => 12
Next Day Air Saver => 13
UPS Next Day Air Early AM =>14
UPS Worldwide Express Plus => 54
UPS Second Day Air AM => 59
UPS Saver => 65
*/

}
%>
          <script type="text/javascript">
            setShippingCost();
          </script>
          <br>
          <script>
            var qs = window.location.search;
            if(qs.indexOf('index=1') > -1) {
              document.write("<font color=red>Your address could not be verified.</font><br>");
            }
          </script>
          Your Address 1: <input type=text id="x_custom_3" onclick="document.getElementById('steps').innerHTML='<img src=/graphics/images/step1.png><br><br>'" name="x_custom_3"/><br><br>
          Your Address 2 (Suite, Apt, etc.): <input type=text id="x_custom_8" name="x_custom_8"/><br><br>
          Your City: <input type=text id="x_custom_4" name="x_custom_4"/><br><br>
          Your State: <input type=text id="x_custom_5" name="x_custom_5"/><br><br>
          Your Zip Code: <input type=text id="x_custom_6" name="x_custom_6" value="<%=zip%>"/><br><span style="background-color:green;color:white;"><a onclick="window.location.href='buy.aspx?t=<%=t%>&w=<%=w%>&zip='+document.getElementById('x_custom_6').value">Set for shipping method.</a></span><br><br>
          Your Country: <input type=text id="x_custom_7" name="x_custom_7"/><br><br><br>
          </div>
          <div style="float:left;width:400">
          <h3>Billing</h3>
          Your Address: <input type=text id="address" onclick="document.getElementById('steps').innerHTML='<img src=/graphics/images/step2.png><br><br>'" name="address"/><br><br>
          Your City: <input type=text id="city" name="city"/><br><br>
          Your State: <input type=text id="state" name="state"/><br><br>
          Your Zip Code: <input type=text id="zipcode" name="zipcode"/><br><br>
          Your Country: <input type=text id="country" name="country"/><br><br><br>
          <input type=hidden id="x_login" name="x_version" value='3.1'/>
          <input type=hidden id="x_login" name="x_delim" value='False'/>
          <input type=hidden id="x_login" name="x_login" value='6r46jMVd4X'/>
          <input type=hidden id="x_tran_key" name="x_tran_key" value='84XDv9Xq2E7ay6s7'/>
          </div>
          <div style="float:left;width:400">
          <h3>Credit Card</h3>
          Your Card Type: 
          <select name="cc">
            <option value="visa">VISA</option>
            <option value="mc">MASTER CARD</option>
            <option value="dsc">DISCOVER</option>
            <option value="amx">AMEX</option>
          </select><br><br>
          Your Credit Card Number: <input type=text id="x_card_num" onclick="document.getElementById('steps').innerHTML='<img src=/graphics/images/step3.png><br><br>'" name="x_card_num"/><br><br>
          Your Exp Date: <input type=text id="x_exp_date" name="x_exp_date"/><br><br>
          Your Security Code: <input type=text id="x_card_code" name="x_card_code"/><br><br>
          <%
          if(t != null && w != null && zip != null) {
          %>
          <input type="submit" value="Proceed to Pay" style="width: 150px; height:50px" />
          <%
          }
          %>
          <input type=hidden id="x_amount" name="x_amount" value='<%=t%>' />
          <input type=hidden id="x_relay_url" name="x_relay_url" value='https://pricebay.gq/relayresponse.asp'/>
          <input type=hidden id="x_relay_response" name="x_relay_response" value='Y'/>
<input type='hidden' name="x_show_form" value="payment_form">
<input type='hidden' name="x_test_request" value="false" />
<input type='hidden' name="x_method" value="cc">
          <input type=hidden id="x_type" name="x_type" value='AUTH_CAPTURE'/>
          <input type=hidden id="x_currency_code" name="x_currency_code" value='USD'/>
          <input type=hidden name="x_custom_1" value='<%=(String) Session["username"]%>' />
          <input type=hidden name="x_custom_2" value='<%=cartid%>' />
          </div>
        </form>
      </div>
  </div>
  <%
connection.Close();
  %>

  </div>

<!--#include file="inc/footer.inc"-->