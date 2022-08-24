// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"  
import "trix"
import "@rails/actiontext"
import './add_jquery'
import Rails from '@rails/ujs';
import e from "trix"
Rails.start();

let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))  
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {  
  return new bootstrap.Popover(popoverTriggerEl)  
})  

setInterval( function(){
     $(".alert").fadeOut(); 
}, 3000);




/*
var grid = document.querySelector('#alts');


var tabEl = document.querySelector('button[data-bs-toggle="tab"]')
tabEl.addEventListener('show.bs.tab', function (event) {
  event.target // newly activated tab
  //event.relatedTarget // previous active tab
  new Masonry(grid,{
    itemSelector: '#alt',
    columnWidth: '#alt',
    percentPosition: true
  });
  
})*/

document.addEventListener("turbo:submit-start", (event) => {
  confirmSubmission(event).then(() => {
    // show progress bar and set submit state here.
    // this block is optional.
  })
})



document.addEventListener("DOMContentLoaded", function(event) {
    console.log("DOM fully loaded and parsed");
      

    var noFavbtns = document.querySelectorAll('#noFavbtn');
     for (let i = 0; i < noFavbtns.length; i++){
      noFavbtns[i].addEventListener('click', function(event) {
          console.log(event.currentTarget);
          console.log("Added to my Favs");
         
      });
    }


    var btns = document.querySelectorAll('a#favorite.fa.fa-heart');

    for (let i = 0; i < btns.length; i++){
      btns[i].addEventListener('click', function(event) {
          console.log(event.currentTarget);
          btns[i].style.visibility = "hidden";
         
          // "Added to My Seven Army favorites."
      });
    }

  });

//document.addEventListener("turbo:before-fetch-response", function() {

    /*console.log('Test');
    
console.log("clicked");
     var noFavbtn = document.getElementById('#noFavorite');
     noFavbtn.style.color = "pink";*/
//});


/*
jQuery.ready( function() {
  var btn = document.querySelector('a#favorite.fa.fa-heart');
  btn.addEventListener("turbo: click", (event) => {
    console.log(event.currentTarget);
    console.log("clicked");
  })
})*/

/*
function toggleFav(e) {
      console.log("click");

      console.log(e.currentTarget);
      console.log("click");
      var parentCol = e.currentTarget.parentNode;
      var btn = e.currentTarget;
       // btn.classList.toggle("fa-heart-o");
       

      if (btn.classList.contains("fa-heart-o")) {
           //btn.hide();
          // parentCol.querySelector("#favorite").style.visibility = "visible";      
      } else if (btn.classList == "fa fa-heart fs-2") {
          //btn.dataset.method = "delete";
          
          //var favFormDiv = document.getElementsByClassName("noFav")[0];
          btn.value.style.visibility = "hidden";
          alert("clicked");
          parentCol.querySelector("#noFav").style.display = "inline-block";  
          alert(btn.style.visibility);
          //const newForm = favFormDiv.cloneNode(true);
          //btn.parentNode.innerHTML = favFormDiv;
          //btn.replaceWith(newForm);
      }
    }



    
document.addEventListener("load", function() { 
    var favs = document.querySelectorAll("a#favorite.fa.fa-heart");//getElementsByClassName("fa-heart");
      for (let i = 0; i < favs.length; i++){
    
      favs[i].addEventListener('click', toggleFav);
    }

  });*/


  




//favbtn.addEventListener("click", (event) => {
  //console.log(event.current.target)
  //document.getElementById("favorite").classList.toggle("fa-heart-o");

//})


function confirmSubmission(event) {
  const button = event.target.querySelector("[data-confirm]")
  const message = button?.dataset?.confirm

  return new Promise(resolve => {
    if (!message || confirm(message)) {
      resolve()
    } else {
      event.detail.formSubmission.stop()
      event.preventDefault()
      event.stopImmediatePropagation()
    }
  })
}




