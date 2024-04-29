import { Controller } from '@hotwired/stimulus'
import Inputmask from 'inputmask'

export default class extends Controller {

  connect() {
    Inputmask('999.999.999-99', {
      removeMaskOnSubmit: true
    }).mask(this.element)
    if(!this.element.innerHTML){
      this.element.innerHTML = '--'
    }
  }
}
