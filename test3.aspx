<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Net" %>  
<%@ Import Namespace="System.Net.Mail" %>  
<%

var fromAddress = new MailAddress("sale.pbay@gmail.com", "Sale");
var toAddress = new MailAddress("dh.cho428@gmail.com", "admin");
const string fromPassword = "coppersink21";
const string subject = "Subject";
const string body = "Body";

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
%>