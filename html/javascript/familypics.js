 var picServiceURL = 'webservice/familypics.py';
 var currPath = '/';
 var currIndex = '0';

 function getDirectories(path) {
    var dataString = 'function=get_directories&path=' + path;
    var subdirectories = Array(); 
    $.ajax({
       async: false,
       url: picServiceURL,
       data: dataString,
       dataType: 'text',
       success: function(data) {
          data = data.trim();
          subdirectories = data.split("|");
       },
       error: function() {
          alert('There was an error retreiving the list of subdirectories.');
       }
    })
    return subdirectories;
 }
 
 function getThumb(path) {
   var dataString = 'function=get_thumbnail&path=' + path;
   var thumb = '';
   $.ajax({
     url: picServiceURL,
     data: dataString,
     success: function(data) {
       thumb = data;
     }
   })
   return thumb;
 }
 
 function loadThumbnails(path) {
   var dataString = 'function=get_thumbnails&path=' + path;
   currPath = path + '/';
   subDirectories = getDirectories(currPath);
   subHeadingText = path + ': ';
   for (var i=0; i<subDirectories.length; i++) {
     subHeadingText += '<a href="#" onclick="loadThumbnails(\'' + path + '/' + subDirectories[i].replace(/\'/g,"\\'") + '\')">' + subDirectories[i] + '</a>&nbsp&nbsp&nbsp';
   }
   $('#subtitle').html(subHeadingText);
   $.ajax({
     async: false,
     url: picServiceURL,
     data: dataString,
     dataType: 'text',
     success: function(data) {
       data = data.trim();
       thumbs = data.split("|");
       var table = $('table#thumbnails');
       table.empty();
       for (var i=0; i<thumbs.length; i++) {
         if (i%4 == 0)
            table.append('<tr>');
        //could maybe search 'tr a[href=*MPG]' and .addClass("movie")?
        //jQuery would need to accept regular expressions or three searches would
        //be needed.
         if (thumbs[i].indexOf(".MPG") > -1 ||
             thumbs[i].indexOf(".MOV") > -1 ||
             thumbs[i].indexOf(".3gp") > -1)
            table.find('tr:last').append('<td class="movie">' + thumbs[i] + '</td>');
         else
            table.find('tr:last').append('<td>' + thumbs[i] + '</td>');    
         if (i%4 == 3)
            table.append('</tr>');
       }
     }
   })
 }

 function getQuantity(path) {
 
 }

 function loadPic(url) {
   
 }
