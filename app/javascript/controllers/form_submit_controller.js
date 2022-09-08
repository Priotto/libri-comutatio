import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

// Connects to data-controller="form-submit"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log('form submit conected')
  }

  submit() {
    Swal.fire({
      text: "Your review was sent!",
      icon: "success",
    });
    this.element.submit();
  }
}
