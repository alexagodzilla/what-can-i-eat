import { Controller } from "@hotwired/stimulus";

// search_form_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["query", "ingredients"];

	search() {
		const query = this.queryTarget.value;
		const ingredients = this.ingredientsTarget.value
			.split(",")
			.map((s) => s.trim());
		const url = new URL(this.element.action);

		url.searchParams.set("query", query);
		url.searchParams.set("ingredients[]", ingredients);

		fetch(url)
			.then((response) => response.text())
			.then((html) => {
				this.element
					.closest("[data-controller='turbo-stream']")
					.dispatchEvent(
						new CustomEvent("turbo:stream:update", { detail: html })
					);
			});
	}
}
