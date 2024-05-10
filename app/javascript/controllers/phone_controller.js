import { Controller } from '@hotwired/stimulus';
import Inputmask from 'inputmask';

export default class extends Controller {
  connect() {
    this.applyMask()
  }

  applyMask() {
    let mask = '(99)9999-9999'
    if (this.element.innerHTML.length === 11) {
      mask = '(99)99999-9999'
    }

    Inputmask(mask, {
      removeMaskOnSubmit: true
    }).mask(this.element)
  }
}
