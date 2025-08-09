# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss", to: "https://ga.jspm.io/npm:tailwindcss@4.1.11/dist/lib.mjs"
pin "@tailwindcss/aspect-ratio", to: "https://ga.jspm.io/npm:@tailwindcss/aspect-ratio@0.4.2/src/index.js"
pin "tailwindcss/plugin", to: "https://ga.jspm.io/npm:tailwindcss@4.1.11/dist/plugin.js"
pin "@tailwindcss/container-queries", to: "https://ga.jspm.io/npm:@tailwindcss/container-queries@0.1.1/dist/index.js"
pin "@tailwindcss/forms", to: "https://ga.jspm.io/npm:@tailwindcss/forms@0.5.10/src/index.js"
pin "mini-svg-data-uri", to: "https://ga.jspm.io/npm:mini-svg-data-uri@1.4.4/index.js"
pin "tailwindcss/colors", to: "https://ga.jspm.io/npm:tailwindcss@4.1.11/dist/colors.js"
pin "tailwindcss/defaultTheme", to: "https://ga.jspm.io/npm:tailwindcss@4.1.11/dist/default-theme.js"
pin "@tailwindcss/typography", to: "https://ga.jspm.io/npm:@tailwindcss/typography@0.5.16/src/index.js"
pin "cssesc", to: "https://ga.jspm.io/npm:cssesc@3.0.0/cssesc.js"
pin "lodash.castarray", to: "https://ga.jspm.io/npm:lodash.castarray@4.4.0/index.js"
pin "lodash.isplainobject", to: "https://ga.jspm.io/npm:lodash.isplainobject@4.0.6/index.js"
pin "lodash.merge", to: "https://ga.jspm.io/npm:lodash.merge@4.6.2/index.js"
pin "postcss-selector-parser", to: "https://ga.jspm.io/npm:postcss-selector-parser@6.0.10/dist/index.js"
pin "util-deprecate", to: "https://ga.jspm.io/npm:util-deprecate@1.0.2/browser.js"
