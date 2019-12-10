
// GET JSON
export const getData = function(url, callback) {
    var request = new XMLHttpRequest();
  
    request.open('GET', url, true);
  
    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
        console.log('status is ALL GOOD !!! ');
        var data = JSON.parse(request.responseText);
        callback(data);
      } else {
        console.log('Error: Request Failed');
      }
    };
  
    request.send();
  }
  

  