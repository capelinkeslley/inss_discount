import {Controller} from "@hotwired/stimulus"

// import { Chart, registerables } from 'chart.js'
// Chart.register(...registerables);

export default class extends Controller {
    static targets = ['myChart'];

    canvasContext() {
      return this.myChartTarget.getContext('2d');
    }

    connect() {
      const chartData = JSON.parse(this.myChartTarget.dataset.value)
      
        new Chart(this.canvasContext(), {
            type: 'bar',
            data: {
              labels: ['Até R$1045,00', 'De R$1045,01 até R$2089,60', 'De R$2089,61 até R$3134,40', 'De  R$3134,41 até R$6101,06'],
              datasets: [{
                label: 'Funcionarios por faixa salarial',
                data: chartData,
                borderWidth: 1,
                backgroundColor: ['#CB4335', '#1F618D', '#F1C40F', '#27AE60'],
              }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
}