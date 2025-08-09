import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-control"
export default class extends Controller {
  static targets = [ "input", "submit" ]

  connect() {
    this.toggleButton()
  }

  clear() {
    this.element.reset()
    this.toggleButton()
  }

  toggleButton() {
    if (this.inputTarget.value) {
      this.submitTarget.style.display = "inline"
    } else {
      this.submitTarget.style.display = "none"
    }
  }
}
