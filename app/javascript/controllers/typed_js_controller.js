import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Trade books,", "Discover new stories!"],
      typeSpeed: 100,
      loop: true
    })
  }
}
