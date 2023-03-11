import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cards"
export default class extends Controller {
  static targets = ["card", "collection"]
  connect() {

  }

  sortCardsAsc() {
    this.cardTargets.sort((a, b) => {
      if (a.dataset.averageRating < b.dataset.averageRating) return -1;
      if (a.dataset.averageRating > b.dataset.averageRating) return 1;
      return 0;
    });
    this.collectionTarget.innerHTML = '';
    this.cardTargets.forEach((card) => console.log());
    // this.collectionTarget.innerHTML = '';
    // this.cardTargets.forEach((card) => {
    //   this.collectionTarget.insertAdjacentHTML('beforeend', card);
    // });
  };

  sortCardsDesc() {
    this.cardTargets.sort((a, b) => {
      if (a.dataset.averageRating < b.dataset.averageRating) return 1;
      if (a.dataset.averageRating > b.dataset.averageRating) return -1;
      return 0;
    });
  };

}
