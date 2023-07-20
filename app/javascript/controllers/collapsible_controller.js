import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="collapsible"
export default class extends Controller {

  dropdown(event) {
    event.target.classList.toggle("active");
    let content = event.target.nextElementSibling;
      if (content.style.display === "block") {
        content.style.display = "none";
      } else {
        content.style.display = "block";
      }
    }
}
