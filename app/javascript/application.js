// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "bootstrap";

import { application } from "../controllers/index.js";
import SearchFormController from "../controllers/search_form_controller.js";
import SearchResultsController from "../controllers/search_results_controller.js";

application.register("search-form", SearchFormController);
application.register("search-results", SearchResultsController);
