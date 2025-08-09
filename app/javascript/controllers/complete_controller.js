import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="complete"
export default class extends Controller {
  connect() {
    console.log('Complted controller connected')
  }

  complete(event) {
    const id = event.target.dataset.id
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch('/todolists/${todo_list_id}/todo/${id}/complete', {
      method: 'PUT', 
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': csrfToken
      }
    })
      .then(response => response.text())
      .then(Turbo.renderStreamMessage)
  }
}
