import "@hotwired/turbo-rails"
import "./controllers"
import * as Popper from "@popperjs/core"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:frame-missing", (event) => {
  const { detail: { response, visit } } = event
  event.preventDefault()
  visit(response)
})

document.addEventListener("turbo:before-frame-render", () => {
  const modal = document.getElementById('modal')
  if (modal) {
    modal.scrollTop = modal.scrollHeight
  }
})

const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

console.log('OOOOOOIIIII')
