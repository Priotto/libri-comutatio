import { Controller } from "@hotwired/stimulus"
//import autocomplete from "autocomplete.js";

export default class extends Controller {

  static targets = ["field"]


  search(query, callback) {
    callback([{ name: "Hello" }])
  }

  connect() {
    this.ac = autocomplete(this.fieldTarget, { hint: false }, [
      {
        source: this.search(),
        debounce: 200,
        templates: {
          suggestion: function (suggestion) {
            return suggestion.name;
          },
        },
      },
    ])
  }
}
