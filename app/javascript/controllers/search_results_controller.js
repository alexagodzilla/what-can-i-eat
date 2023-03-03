import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["list"];

	update(event) {
		const [data, status, xhr] = event.detail;
		this.listTarget.innerHTML = data;
	}
}
