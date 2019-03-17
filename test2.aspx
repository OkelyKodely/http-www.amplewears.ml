<%@ Page Language="C#" Debug="true" %>

<%

string s_address, s_city, s_state, s_zipcode, s_country, x_login, x_tran_key, x_card_num, x_exp_date, Amount, shipping;

x_login = "6r46jMVd4X";

x_tran_key = "84XDv9Xq2E7ay6s7";

x_card_num = "4111111111111111";

x_exp_date = "12/29";

shipping = "UPS Ground - $12.04";

Amount = "33.34";

s_address = "384 S. Wdfsaest Ave. #15";

s_city = "Los Angeles";

s_state = "CA";

s_zipcode = "40006";

s_country = "US";

string post_string = "";
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

Response.Write(post_string);

MyWebRequest m = new MyWebRequest("https://test.authorize.net/gateway/transact.dll", "POST", post_string);
String post_response = m.GetResponse();

Response.Write(post_response);

String[] response_array = post_response.Split(',');
if(response_array[0].Equals("1")) {
  Response.Write("Authorized!");
} else {
  Response.Write("Not authorized!");
}
%>