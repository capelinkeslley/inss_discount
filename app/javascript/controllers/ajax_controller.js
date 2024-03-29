import { Controller } from "@hotwired/stimulus"

import lodash from "lodash"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }

  makeRequest() {
    // lodash.debounce(() => {console.log('ola')}, 700)()
    lodash.debounce(() => { 
      const metaTag = document.querySelector('meta[name="csrf-token"]');
      const proponentGrossSalary = document.getElementById("proponent_gross_salary").value
      fetch("/proponents/calculate_discount", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': metaTag.getAttribute('content')
        },
        body: JSON.stringify({ gross_salary: proponentGrossSalary })
      })
      .then(response => response.json())
      .then(data => {
        document.getElementById("proponent_discount").value = data.discount
      })
      .catch(error => {
        console.error("Erro ao fazer a solicitação:", error);
      });
    }, 700)()
  }

  debounce(func, timeout = 500){
    let timer;
    return (...args) => {
      clearTimeout(timer);
      timer = setTimeout(() => { func.apply(this, args); }, timeout);
    }
  }

  getCSRFToken = () => {
    const metaTag = document.querySelector('meta[name="csrf-token"]');
    return metaTag.getAttribute('content');
  };
}
