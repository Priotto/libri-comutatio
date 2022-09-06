import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers";
import { Autocomplete } from 'stimulus-autocomplete'
import ScrollTo from 'stimulus-scroll-to'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
const context = require.context("./", true, /\.js$/);
application.register('autocomplete', Autocomplete)
application.register('scroll-to', ScrollTo)
application.load(definitionsFromContext(context));
window.Stimulus   = application

export { application }
