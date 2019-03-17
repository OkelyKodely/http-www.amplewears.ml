<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Data.Odbc" %>  
<%@ Import Namespace="System.Data.SqlClient" %>  
<%@ Import Namespace="UPSShipping" %>  

<%

String s_address, s_city, s_state, s_zipcode, s_country, x_login, x_tran_key, x_card_num, x_exp_date, Amount, shipping;

x_login = "6r46jMVd4X";

x_tran_key = "84XDv9Xq2E7ay6s7";

x_card_num = "4111111111111111";

x_exp_date = "12/29";

Amount = "33.34";

s_address = "384 S. Wdfsaest Ave. #15";

s_city = "Los Angeles";

s_state = "CA";

s_zipcode = "40006";

s_country = "US";

UPSShipping.UPSAVS u = new UPSShipping.UPSAVS();
if(u.GetAVS(s_address, s_city, s_state, s_zipcode, s_country)) {


  Response.Write("Verified!");
} else {
  Response.Write("Not verified!");
}
%>