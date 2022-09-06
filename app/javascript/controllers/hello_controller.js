import { Controller } from "@hotwired/stimulus"
//import autocomplete from "autocomplete.js";

export default class extends Controller {

  static targets = ["field"]


  search(query, callback) {
    callback([{ name: "Hello" }])
  }

  connect() {
  }
}
