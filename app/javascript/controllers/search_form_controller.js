import { Controller } from "@hotwired/stimulus";

// search_form_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
	// The form element has a data-target attribute with the name of the input
	static targets = ["query", "ingredients"];
	// The form element has a data-action attribute with the name of the method which is called search()
	search() {
		// Get the values from the form
		const query = this.queryTarget.value;
		// Split the ingredients string into an array
		const ingredients = this.ingredientsTarget.value
			.split(",")
			.map((s) => s.trim());
		// Create a new URL object from the form action
		const url = new URL(this.element.action);
		// Set the query and ingredients parameters on the URL object
		url.searchParams.set("query", query);
		url.searchParams.set("ingredients[]", ingredients);
		// Fetch the URL which contains the query and ingredients parameters
		fetch(url)
			// Get the response as text
			.then((response) => response.text())
			// parse the response as HTML
			.then((html) => {
				// this.element is the form element
				this.element
					// Find the closest parent element with a data-controller attribute with the value of turbo-stream
					.closest("[data-controller='turbo-stream']")
					// Dispatch a custom event with the name turbo:stream:update and the detail of the HTML
					.dispatchEvent(
						// Create a new CustomEvent with the name turbo:stream:update and the detail of the HTML which is the response from the fetch
						new CustomEvent("turbo:stream:update", { detail: html })
					);
			});
	}
}
// the dispatchEvent() method dispatches an event at the specified target, which is the closest parent element with a data-controller attribute with the value of turbo-stream. In this case, the form element is the target. This information is passed to the event handler in the search_results_controller.js file.
