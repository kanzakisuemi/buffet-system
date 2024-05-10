import { Controller } from '@hotwired/stimulus'
import Inputmask from 'inputmask'

export default class extends Controller {

  connect() {
    Inputmask('currency', {
      removeMaskOnSubmit: true
    }).mask(this.element)
    if(!this.element.innerHTML){
      this.element.innerHTML = '0,00'
    }
  }
}
