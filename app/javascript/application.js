import "@hotwired/turbo-rails"
import "./controllers"
import * as Popper from "@popperjs/core"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:frame-missing", (event) => {
  const { detail: { response, visit } } = event
  event.preventDefault()
  visit(response)
})

const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
