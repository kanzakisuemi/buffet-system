import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showhide"
export default class extends Controller {
  static targets = ["input", "output"]
  static values = { showIf: String }
  connect() {
    // this.outputTarget.hidden = true
    this.toggle()
  }

  toggle() {
    if (this.inputTarget.value != this.showIfValue) {
      this.outputTarget.hidden = true
    } else if (this.inputTarget.value == this.showIfValue) {
      this.outputTarget.hidden = false
    }
  }
}
