import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['url', 'file', 'prompt']

  showButton(event) {
    this.promptTarget.classList.add('d-none')
    if (event.currentTarget.dataset.choice === "url") {
      this.urlTarget.classList.remove('d-none')
    } else {
      this.fileTarget.classList.remove('d-none')
    }
  }
}
