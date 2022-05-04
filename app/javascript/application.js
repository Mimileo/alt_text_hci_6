// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"  
import "trix"
import "@rails/actiontext"
import pixelmatch from "pixelmatch"


let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))  
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {  
  return new bootstrap.Popover(popoverTriggerEl)  
})  

document.addEventListener("turbo:submit-start", (event) => {
  confirmSubmission(event).then(() => {
    // show progress bar and set submit state here.
    // this block is optional.
  })
})

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


