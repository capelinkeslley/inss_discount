import { Controller } from "@hotwired/stimulus"

import Inputmask from "inputmask";

export default class extends Controller {
  connect() {
  }

  documentMask(){
    const element = this.element

    Inputmask('999.999.999-99').mask(element)
  }
}
