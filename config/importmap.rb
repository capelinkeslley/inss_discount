# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "lodash" # @4.17.21
pin "inputmask" # @5.0.8
pin "chart.js" # @4.4.2
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.2
