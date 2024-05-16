import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showhide-checkbox"
export default class extends Controller {
  static targets = ["input", "output"]
  connect() {
    this.toggle()
  }

  toggle() {
    if (this.inputTarget.checked == false) {
      this.outputTarget.hidden = true
    } else if (this.inputTarget.checked == true) {
      this.outputTarget.hidden = false
    }
  }
}
