import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  connect() {
    this.element.dataset.menuReady = "true"
  }

  disconnect() {
    delete this.element.dataset.menuReady
  }

  toggle() {
    const expanded = this.toggleTarget.getAttribute("aria-expanded") !== "true"
    this.toggleTarget.setAttribute("aria-expanded", String(expanded))
    this.element.classList.toggle("menu-open", expanded)
  }
}
