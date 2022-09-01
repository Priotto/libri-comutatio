import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers";
import { Autocomplete } from 'stimulus-autocomplete'


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
const context = require.context("./", true, /\.js$/);
application.register('autocomplete', Autocomplete)
application.load(definitionsFromContext(context));
window.Stimulus   = application

export { application }
