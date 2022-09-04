import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  static target = ["input"]

  connect() {
    console.log('form submit conected')
  }

  submit() {
    this.inputTarget.submit();
  }
}
