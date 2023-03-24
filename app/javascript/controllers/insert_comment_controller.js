import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-comment"
export default class extends Controller {

  static targets = ["form", "comments"]
  static values = { position: String }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_item) {
        this.commentsTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
      }
      this.formTarget.outerHTML = data.form
    })
  }
}
