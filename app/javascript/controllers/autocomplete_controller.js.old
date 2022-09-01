import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="title-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["field"]

  search(query, callback) {
    callback([{ name: "Hello" }])
  }

  connect() {
    console.log("conectou")
  }

  disconnect() {
    //this.geocoder.onRemove()
  }
}
