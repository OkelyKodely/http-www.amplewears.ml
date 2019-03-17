using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;
using System.Net;

namespace UPSShipping
{
    public class UPSAVS
    {

        private string m_accessNumber;
        private string m_userName;
        private string m_password;
        private string m_uri = "https://onlinetools.ups.com/ups.app/xml/XAV";

        #region Properties

        public string AccessNumber
        {
            get { return m_accessNumber; }
            set { m_accessNumber = value; }
        }

        public string UserName
        {
            get { return m_userName; }
            set { m_userName = value; }
        }

        public string Password
        {
            get { return m_password; }
            set { m_password = value; }
        }

        public string Uri
        {
            get { return m_uri; }
            set { m_uri = value; }
        }

        #endregion

        #region Classes
        public UPSAVS()
        {
        }

        public UPSAVS(string accessNumber, string userName, string password, string shipperNumber)
        {
            m_accessNumber = accessNumber;
            m_userName = userName;
            m_password = password;
        }

        #endregion

        #region Methods
        public void setCredentials(string accessNumber, string userName, string password)
        {
            m_accessNumber = accessNumber;
            m_userName = userName;
            m_password = password;
        }

        public bool GetAVS(string address, string city, string state, string ZipCode, string country)
        {            
            WebRequest req = WebRequest.Create(m_uri);
            WebResponse rsp;
            req.Method = "POST";
            req.ContentType = "text/xml";
            StreamWriter writer = new StreamWriter(req.GetRequestStream());
            writer.WriteLine(buildUPSXml(address, city, state, ZipCode, country));
            writer.Close();
            rsp = req.GetResponse();

            //Get the Posted Data
            StreamReader reader = new StreamReader(rsp.GetResponseStream());
            string rawXml = reader.ReadToEnd();
            XmlDocument xml = new XmlDocument();
            xml.LoadXml(rawXml);

            using (var stringWriter = new StringWriter())
            using (var xmlTextWriter = XmlWriter.Create(stringWriter))
            {
                xml.WriteTo(xmlTextWriter);
                xmlTextWriter.Flush();
                String result = stringWriter.GetStringBuilder().ToString();
                if(result.IndexOf("<AddressLine>") > -1 && address.Length > 0) {
                    return true;
                }
            }
            return false;
        }

        public string buildUPSXml(string s_address, string s_city, string s_state, string s_zipcode, string s_country)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("<?xml version=\"1.0\"?>");
            sb.Append("<AccessRequest xml:lang=\"en-US\">");
            sb.Append("<AccessLicenseNumber>9D5A1C57FAB32998</AccessLicenseNumber>");
            sb.Append("<UserId>dhcho428</UserId>");
            sb.Append("<Password>coppersink21</Password>");
            sb.Append("</AccessRequest>");
            sb.Append("<?xml version=\"1.0\"?>");
            sb.Append("<AddressValidationRequest xml:lang=\"en-US\">");
            sb.Append("<Request>");
            sb.Append("<TransactionReference>");
            sb.Append("<CustomerContext>Summary Description</CustomerContext>");
            sb.Append("<XpciVersion>1.0</XpciVersion>");
            sb.Append("</TransactionReference>");
            sb.Append("<RequestAction>XAV</RequestAction>");
            sb.Append("<RequestOption>3</RequestOption>");
            sb.Append("</Request>");
            sb.Append("<AddressKeyFormat>");
            sb.Append("<AddressLine>"+s_address+"</AddressLine>");
            sb.Append("<PoliticalDivision2>"+s_city+"</PoliticalDivision2>");
            sb.Append("<PoliticalDivision1>"+s_state+"</PoliticalDivision1>");
            sb.Append("<PostcodePrimaryLow>"+s_zipcode+"</PostcodePrimaryLow>");
            sb.Append("<CountryCode>"+s_country+"</CountryCode>");
            sb.Append("</AddressKeyFormat>");
            sb.Append("</AddressValidationRequest>");

            return sb.ToString();
        }
        #endregion
    }    
}