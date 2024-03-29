import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    this.element.reset()
    // this.element.querySelector("input:not([type=hidden])").focus()
    // this.element.querySelector("input[autofocus]")
    this.element.querySelector("[autofocus='autofocus]")?.focus()
  }
}
