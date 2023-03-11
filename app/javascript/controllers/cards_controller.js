import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cards"
export default class extends Controller {
  static targets = ["card", "container"]

  sortCardsAsc() {
    this.cardTargets
      .sort((a, b) => parseFloat(a.dataset.averageRating) - parseFloat(b.dataset.averageRating))
      .forEach((card) => this.containerTarget.appendChild(card));
  };

  sortCardsDesc() {
    this.cardTargets
      .sort((a, b) => parseFloat(b.dataset.averageRating) - parseFloat(a.dataset.averageRating))
      .forEach((card) => this.containerTarget.appendChild(card));
  };
}
