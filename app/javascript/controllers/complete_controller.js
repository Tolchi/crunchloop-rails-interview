import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="complete"
export default class extends Controller {
  connect() {
    console.log('Complted controller connected')
  }

  complete(event) {
    const id = event.target.dataset.id
    const todoListId = event.target.dataset.todoListId
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/todolists/${todoListId}/todos/${id}/complete`, {
      method: 'PUT',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ completed: event.target.checked })
    })
      .then(response => response.text())
      .then(Turbo.renderStreamMessage)
  }
}
