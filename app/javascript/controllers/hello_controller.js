import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    function myFunction(x) {
      if (x.matches) { // If media query matches
        document.getElementsByClassName("d-xtra-small");
      } else {
        document.body.style.backgroundColor = "pink";
      }
    }

    
    var favs = document.getElementsByClassName("fa-heart");
    for (let i = 0; i < favs.length; i++){
    
      favs[i].style.color ="pink";
    }
    var x = window.matchMedia("(max-width: 700px)")
    xtra_small = document.getElementsByClassName("d-xtra-small");
    myFunction(x) // Call listener function at run time
    x.addListener(myFunction) // Attach listener function on state changes
  }
}


