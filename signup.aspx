<!--#include file="inc/header.aspx"-->

  <script language="javascript">

    function interpretUsername(username) {
  
      return username.value.length > 5;
  
    }

    function interpretEmail(email) {
  
      if (/^(\S+)@(\S+).(\S+)/.exec(email)) {
  
        return true;
  
      } else {
  
        return false;
  
      }
  
    }

    function validateThenSubmit() {
  
      var frm = document.getElementById("frm");

      var username = document.getElementById("username");
  
      var usernameIsValid = interpretUsername(username);

      var email = document.getElementById("email").value;
  
      var emailIsValid = interpretEmail(email);

      if(usernameIsValid &&
         emailIsValid) {
  
        frm.submit();
  
      } else {
  
        alert("fix your errors!!~");
  
      }
  
    }
  
  </script>

  <%
  String firstname;
  String lastname;
  String username;
  String password;
  String pusername;
  String address;
  String city;
  String stateorprovince;
  String country;
  String phone;
  String fax;
  String email;
  String subscribe;

  firstname = Request["firstname"];
  lastname = Request["lastname"];
  username = Request["username"];
  password = Request["password"];
  pusername = Request["pusername"];
  address = Request["address"];
  city = Request["city"];
  stateorprovince = Request["stateorprovince"];
  country = Request["country"];
  phone = Request["phone"];
  fax = Request["fax"];
  email = Request["email"];
  subscribe = Request["subscribe"];

  if(firstname != null) {

    String queryString = "SELECT * FROM shoppers2 WHERE email = '"+email+"'";

    command = new OdbcCommand(queryString, connection);

    OdbcDataReader reader = command.ExecuteReader();

    if(reader.Read()) {


      if(subscribe != null) {

        if(subscribe.Equals("checked"))
          subscribe = "1";
        else
          subscribe = "0";

      } else {

        subscribe = "0";

      }

      queryString = "INSERT INTO shoppers2 (subscribe, firstname, lastname, username, password, address, city, stateorprovince, country, phone, fax, email, paypal_user) VALUES ("+subscribe+",'"+firstname+"','"+lastname+"','"+username+"','"+password+"','"+address+"','"+city+"','"+stateorprovince+"','"+country+"','"+phone+"','"+fax+"','"+email+"','"+pusername+"')";

      command = new OdbcCommand(queryString, connection);
      command.ExecuteNonQuery();

      Response.Write("Registered!");

    } else {
    %>
    <script>
      alert('Account for email <%=email%> already exists.');
    </script>
    <%
    }

  }
  %>

  <div style="height:1000px;float:left;position:relative;top:200px">
    <div style="height:80px">
      <div>
      <span style="font-size:40px;">Sign Up - Create Account</span><br>
      <span><br></span>
      <span><br></span>
    </div>
    </div>
    <form method="post" id="frm" action="" onsubmit="return validateThenSubmit()">
      <div style="float:left;width:140px">First Name:</div>
      <div style="loat:left"><input type="text" name="firstname"></div>
      <div style="float:left;width:140px">Last Name:</div>
      <div style="loat:left"><input type="text" name="lastname"></div>
      <div style="float:left;width:140px">Username:</div>
      <div style="loat:left"><input type="text" id="username" name="username"></div>
      <div style="float:left;width:140px">Password:</div>
      <div style="loat:left"><input type="password" name="password"></div>
      <div style="float:left;width:140px">Paypal Username:</div>
      <div style="loat:left"><input type="text" id="pusername" name="pusername"></div>
      <div style="float:left;width:140px">Address:</div>
      <div style="loat:left"><input type="text" name="address"></div>
      <div style="float:left;width:140px">City:</div>
      <div style="loat:left"><input type="text" name="city"></div>
      <div style="float:left;width:140px"><nobr>State or Province:</nobr></div>
      <div style="loat:left"><input type="text" name="stateorprovince"></div>
      <div style="float:left;width:140px">Country:</div>
      <div style="loat:left"><input type="text" name="country"></div>
      <div style="float:left;width:140px">Phone:</div>
      <div style="loat:left"><input type="text" name="phone"></div>
      <div style="float:left;width:140px">Fax:</div>
      <div style="loat:left"><input type="text" name="fax"></div>
      <div style="float:left;width:140px">Email:</div>
      <div style="loat:left"><input type="text" id="email" name="email"></div>
      <div style="float:left;width:140px">Subscribe:</div>
      <div style="loat:left"><input type="checkbox" id="subscribe" name="subscribe"> yes?</div>
      <p style="font-size:11px">You are given the option to subscribe to our marketing material.  <br>By checking "yes" on Subscribe you agree to receive information from us <br>regarding our products and services from time to time.</p>
      <br><br>
      <input type="submit" value="Sign Up" style="width:350px; height:50px; position: relative; left: 0px">
    </form>
  </div>
  <%
connection.Close();
  %>
<!--#include file="inc/footer.inc"-->