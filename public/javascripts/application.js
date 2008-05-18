$(document).ready(function() {
   $(".ajax_link").bind('click', function() {
       var element = $(this);
       $.ajax({
         type: 'GET',
         url: element.attr('href')+'.js',
         dataType: 'script'
       })
       return false;
     })
 });