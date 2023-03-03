import { Controller } from "@hotwired/stimulus";
// html from the seach_form controller is passed to the search_results controller
// Connects to data-controller="search-results"
// search_results_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["list"];
	// The event handler for the turbo:stream:update event. The event handler is called when the form element dispatches the turbo:stream:update event. The event handler receives the event object as an argument. The event handler sets the innerHTML of the listTarget to the HTML from the fetch request. The listTarget is the element with a data-target attribute with the value of list. update() is a method that is called when the turbo:stream:update event is dispatched. It receives the event object as an argument. The event object has a detail property which contains the HTML from the fetch request in the search_form_controller.js file. The event handler sets the innerHTML of the listTarget to the HTML from the fetch request. The listTarget is the element with a data-target attribute with the value of list.
	update(event) {
		// data is the HTML from the fetch request. it contains the HTML from the search_results view. it is destructured from the event.detail array. destructuring is a JavaScript feature that allows you to extract data from an array or object and assign it to a variable. The event.detail array contains the HTML from the fetch request. the HTML is assigned to the data variable. The event.detail array contains the HTML from the fetch request. The HTML is assigned to the data variable.
		const [data] = event.detail;
		this.listTarget.innerHTML = data;
	}
}

// The syntax for desstructuring depends on the type of data that is being destructured. If the data is an array, the syntax is [data] = event.detail. If the data is an object, the syntax is { data } = event.detail.
