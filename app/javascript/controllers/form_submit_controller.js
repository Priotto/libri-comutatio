import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log('form submit conected')
  }

  teste() {
    // console.log(this.inputTarget)
    console.log(this.element);
    this.element.submit();
  }
}
