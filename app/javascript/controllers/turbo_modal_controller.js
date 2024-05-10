import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    this.element.onclick = () => {
      const modal = document.getElementById("modal")
      modal.classList.add("d-none")
      location.reload()
      // history.back()
    }
  }
}
