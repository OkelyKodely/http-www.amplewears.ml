<!--#include file="inc/header.aspx"-->
<%
    String itemid, category;

    itemid = Request["itemid"];
    
  String queryString = "SELECT price,category,itemid,name,image,dsc,discount,newarrivals FROM products2 WHERE itemid=" + itemid;

command = new OdbcCommand(queryString, connection);
OdbcDataReader reader = command.ExecuteReader();

    if(reader.Read()) {
      category = reader.GetString(1);
    }
  %>
  <div>
  
    <%
    String cartid;

    cartid = (String) Session["cartid"];

    if(cartid == null) {

      queryString = "SELECT max(cid)+1 AS cid FROM cart";

      command = new OdbcCommand(queryString, connection);
      reader = command.ExecuteReader();

      if(reader.Read()) {
        cartid = reader.GetString(0);
      } else {
        cartid = "1";
      }

      Session["cartid"] = cartid;
      
    }

    queryString = "SELECT dsc, image, itemid, name, price FROM products2 WHERE itemid=" + itemid;

    command = new OdbcCommand(queryString, connection);
    reader = command.ExecuteReader();

    String dsc;

    if(reader.Read()) {
      dsc = reader.GetString(0);
      //dsc = dsc.Substring(0, 1000);
    %><Br /><br><br><br>
  <div id = "container" style="height:600px">
      <div id = "middle" style = "float:left; width: 700px;">
<style>
* {box-sizing: border-box;}

.img-zoom-container {
  position: relative;
}

.img-zoom-lens {
  position: absolute;
  border: 1px solid #d4d4d4;
  /*set the size of the lens:*/
  width: 40px;
  height: 40px;
}

.img-zoom-result {
  border: 1px solid #d4d4d4;
  /*set the size of the result div:*/
  width: 300px;
  height: 300px;
}
</style>
<script>
function imageZoom(imgID, resultID) {
  var img, lens, result, cx, cy;
  img = document.getElementById(imgID);
  result = document.getElementById(resultID);
  /*create lens:*/
  lens = document.createElement("DIV");
  lens.setAttribute("class", "img-zoom-lens");
  /*insert lens:*/
  img.parentElement.insertBefore(lens, img);
  /*calculate the ratio between result DIV and lens:*/
  cx = result.offsetWidth / lens.offsetWidth;
  cy = result.offsetHeight / lens.offsetHeight;
  /*set background properties for the result DIV:*/
  result.style.backgroundImage = "url('" + img.src + "')";
  result.style.backgroundSize = (img.width * cx) + "px " + (img.height * cy) + "px";
  /*execute a function when someone moves the cursor over the image, or the lens:*/
  lens.addEventListener("mousemove", moveLens);
  img.addEventListener("mousemove", moveLens);
  /*and also for touch screens:*/
  lens.addEventListener("touchmove", moveLens);
  img.addEventListener("touchmove", moveLens);
  function moveLens(e) {
    var pos, x, y;
    /*prevent any other actions that may occur when moving over the image:*/
    e.preventDefault();
    /*get the cursor's x and y positions:*/
    pos = getCursorPos(e);
    /*calculate the position of the lens:*/
    x = pos.x - (lens.offsetWidth / 2);
    y = pos.y - (lens.offsetHeight / 2);
    /*prevent the lens from being positioned outside the image:*/
    if (x > img.width - lens.offsetWidth) {x = img.width - lens.offsetWidth;}
    if (x < 0) {x = 0;}
    if (y > img.height - lens.offsetHeight) {y = img.height - lens.offsetHeight;}
    if (y < 0) {y = 0;}
    /*set the position of the lens:*/
    lens.style.left = x + "px";
    lens.style.top = y + "px";
    /*display what the lens "sees":*/
    result.style.backgroundPosition = "-" + (x * cx) + "px -" + (y * cy) + "px";
  }
  function getCursorPos(e) {
    var a, x = 0, y = 0;
    e = e || window.event;
    /*get the x and y positions of the image:*/
    a = img.getBoundingClientRect();
    /*calculate the cursor's x and y coordinates, relative to the image:*/
    x = e.pageX - a.left;
    y = e.pageY - a.top;
    /*consider any page scrolling:*/
    x = x - window.pageXOffset;
    y = y - window.pageYOffset;
    return {x : x, y : y};
  }
}
</script>

<div class="img-zoom-container" style="float:left">
  <div style="float:left">
    <p style="width:350px"><b>Name:</b> <%=reader.GetString(3)%></p>
    <img id="myimage" src='/productitems/<%=reader.GetString(1)%>' width="300" height="240">
  </div>
  <div style="float:left;position:relative;top:30px;left:0px">
    <div id="myresult" class="img-zoom-result"></div>
    <span style="font-size:24px">Zoom</span>
  </div>
</div>
        <script>imageZoom("myimage", "myresult"); </script>
      </div>
      <div id = "right" style = "float:left;width:300px">
        <span style="color:#000"><b>Description:</b></span>
        <%=dsc%>...<br><br>
        <span style="color:#ff0000"><b>Price:</b></span>
        <span style="color:#ff0000">$<%=reader.GetString(4)%></span><br><br>
        <form method="post" action="cart.aspx">
          <input type="hidden" name="itemid" value=<%=reader.GetDecimal(2)%>>
          <input type="image" src="/graphics/images/addtocart.png" border="0" name="submit">
        </form>
      </div>
  </div>
    <%
}

connection.Close();
%>
<!--#include file="inc/footer.inc"-->