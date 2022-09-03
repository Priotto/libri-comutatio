import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  connect() {
    console.log('form submit conected')
  }

  submit() {
    this.element.submit();
  }
}
