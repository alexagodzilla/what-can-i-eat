import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-results"
// search_results_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["list"];

	update(event) {
		const [data, status, xhr] = event.detail;
		this.listTarget.innerHTML = data;
	}
}
