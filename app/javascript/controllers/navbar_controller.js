import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }
  updateNavbar() {
    if (window.scrollY >= window.innerHeight) {
      this.element.classList.add("navbar-white")
    } else {
      this.element.classList.remove("navbar-white")
    }
  }
}


