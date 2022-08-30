import { Controller } from "@hotwired/stimulus"
import Books from "../../services/books"
application.register("books", Books)


// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["title"]

  connect() {
    const search_by_title = fetch.book.title()
    fetch.book.title()
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
