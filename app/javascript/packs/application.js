import 'materialize-css'
import 'materialize-css/sass/materialize.scss'

console.log('Hello World from Webpacker')

$(document).ready(() => {
  console.log('ready');
  $('.datepicker').pickadate({
    selectMonth: true,
    selectYears: 15,
    today: 'Today',
    clear: 'Clear',
    close: 'OK',
    closeOnSelect: false,
  })
})
