import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["target", "template"]

  add(e) {
    e.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.targetTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(e) {
    e.preventDefault()
    const wrapper = e.target.closest('.nested-fields')

    if (wrapper.dataset.newRecord === 'true') {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'
      const destroyInput = wrapper.querySelector("input[name*='_destory']")
      if (destroyInput) destroyInput.value = "1"
    }
  }
}
