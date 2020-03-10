<% Dir.foreach('public/uploads') do |picture| %>
    <div class="gallery">
      <a target="_blank" href="../../public/uploads/pig3.jpg">
        <img src="../../public/uploads/pig3.jpg" alt="" width="600" height="400">
      </a>
      <div class="desc"><%= picture %></div>
    </div>
    
    <% end %>

    <!DOCTYPE html>
<html>
<head>
<style>
div.gallery {
  margin: 5px;
  border: 1px solid #ccc;
  float: left;
  width: 180px;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 100%;
  height: auto;
}

div.desc {
  padding: 15px;
  text-align: center;
}
</style>
</head>
<body>


<div class="gallery">
  <img src="../pic2.jpg" alt="" width="600" height="400">
</div>

</body>
</html>
<img src="/uploads/pic1.jpg" alt="1">