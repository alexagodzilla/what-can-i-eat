import { Controller } from "@hotwired/stimulus"
import StarRating from "star-rating.js"

export default class extends Controller {
  static targets = ["select"]

  connect() {
    new StarRating(this.selectTarget);
  }
}
