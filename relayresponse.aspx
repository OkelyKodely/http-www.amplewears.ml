<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Data.Odbc" %>  
<%@ Import Namespace="System.Data.SqlClient" %>  
<%@ Import Namespace="UPSShipping" %>  
<%@ Import Namespace="System.Net" %>  
<%@ Import Namespace="System.Net.Mail" %>  

<%

string mailtothisfool = "";

string s_address, s_city, s_state, s_zipcode, s_country, x_login, x_tran_key, x_card_num, x_exp_date, Amount, shipping, username, cartid;

x_login = Request["x_login"];

x_tran_key = Request["x_tran_key"];

x_card_num = Request["x_card_num"];

x_exp_date = Request["x_exp_date"];

Amount = Request["x_amount"];

shipping = Request["shipping"];

username = Request["x_custom_1"];

cartid = Request["x_custom_2"];

s_address = Request["x_custom_3"];

s_city = Request["x_custom_4"];

s_state = Request["x_custom_5"];

s_zipcode = Request["x_custom_6"];

s_country = Request["x_custom_7"];

string s_address2;

s_address2 = Request["x_custom_8"];
int continu = 0;

UPSShipping.UPSAVS u = new UPSShipping.UPSAVS();
if(u.GetAVS(s_address, s_city, s_state, s_zipcode, s_country)) {
  continu = 1;
} else {
  continu = 0;
}

String post_string = "";

if(continu != 1) {

    Response.Redirect("paymentfailed.aspx");

} else

    post_string += "x_login=" + System.Uri.EscapeDataString(x_login) + "&";
    post_string += "x_tran_key=" + System.Uri.EscapeDataString(x_tran_key) + "&";
    post_string += "x_delim_data=TRUE&";
    post_string += "x_delim_char=,&";
    post_string += "x_relay_response=FALSE&";
    post_string += "x_type=AUTH_CAPTURE&";
    post_string += "x_method=CC&";
    post_string += "x_card_num=" + System.Uri.EscapeDataString(x_card_num) + "&";
    post_string += "x_exp_date=" + System.Uri.EscapeDataString(x_exp_date) + "&";

    String[] sh = shipping.Split('$');

    Amount = (Convert.ToDouble(Amount) + Convert.ToDouble(sh[1])) + "";

    post_string += "x_amount=" + System.Uri.EscapeDataString(Amount) + "&";
    post_string += "x_description=Auth Cap Transaction";

    //Response.Write(post_string);

    MyWebRequest m = new MyWebRequest("https://test.authorize.net/gateway/transact.dll", "POST", post_string);
    String post_response = m.GetResponse();

    //Response.Write(post_response);

    String[] response_array = post_response.Split(',');
    if(response_array[0].Equals("1")) {
    //  Response.Write("Authorized!");

    OdbcConnection connection = new OdbcConnection();

    OdbcCommand command;

    connection.ConnectionString = "Driver={Oracle in XE};Server=localhost;Uid=sa;Pwd=coppersink21;";

    String queryString = "SELECT email FROM shoppers2 WHERE username='" + username + "'";

    command = new OdbcCommand(queryString, connection);
    connection.Open();

    using (OdbcDataReader reader = command.ExecuteReader())
    {
        if(reader.Read()) {
            mailtothisfool = reader.GetString(0);
        }
    }

    String ShippingMethod, ShippingCost;
    ShippingMethod = sh[0].Replace(" - ", "");
    ShippingCost = sh[1];
    queryString = "INSERT INTO \"order2\" (transid, cc4, status, shippingmethod, shippingcost, username, price, inputdate, s_address, s_city, s_state, s_zipcode, s_country) VALUES " + "('"+response_array[6]+"', '"+x_card_num.Substring(x_card_num.Length-5, 4)+"', 'processing...', '"+ShippingMethod+"',"+ShippingCost+",'"+username+"',"+Amount+",sysdate,'"+s_address+" "+s_address2+"','"+s_city+"','"+s_state+"','"+s_zipcode+"','"+s_country+"')";

    command = new OdbcCommand(queryString, connection);
    command.ExecuteNonQuery();

    queryString = "SELECT orderid FROM \"order2\" ORDER BY orderid DESC";

    command = new OdbcCommand(queryString, connection);
    OdbcDataReader reader1 = command.ExecuteReader();

    String orderid;

    if(reader1.Read()) {

      orderid = reader1.GetString(0);

      queryString = "SELECT itemid FROM cart2 where cid = " + cartid;

      command = new OdbcCommand(queryString, connection);
      reader1 = command.ExecuteReader();

      while(reader1.Read()) {

        String itemid;

        itemid = reader1.GetString(0);

        queryString = "INSERT INTO orderitems2 (orderid,itemid) VALUES ("+orderid+","+itemid+")";

        OdbcCommand com = new OdbcCommand(queryString, connection);
        com.ExecuteNonQuery();
      }
    }

    queryString = "DELETE FROM cart2 WHERE cid = " + cartid;

    OdbcCommand com2 = new OdbcCommand(queryString, connection);

    com2.ExecuteNonQuery();

    var fromAddress = new MailAddress("sale.pbay@gmail.com", "Sale");
    var toAddress = new MailAddress(mailtothisfool, mailtothisfool);

    const string fromPassword = "coppersink21";
    const string subject = "Your AmpleWears Order";
    string body = "You have bought some items from AmpleWears.ml in the amount of $" + Amount + " USD.  Thank you for doing business with us.  We will process your order shortly.  Thanks from the priceBay team";

    var smtp = new SmtpClient
    {
        Host = "smtp.gmail.com",
        Port = 587,
        EnableSsl = true,
        DeliveryMethod = SmtpDeliveryMethod.Network,
        UseDefaultCredentials = false,
        Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
    };
    using (var message = new MailMessage(fromAddress, toAddress)
    {
        Subject = subject,
        Body = body
    })
    {
        smtp.Send(message);
    }

    connection.Close();
    Response.Redirect("thankyou.aspx", false);

} else {
%>
<script type="text/javascript">window.location = document.referrer + '&index=1';</script>
<%
}
%>