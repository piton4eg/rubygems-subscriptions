# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'click', '#download_links .download_button', ->
    $('#status_label').html('Download...')
  $(document).on 'click', '#update_link .update_button', ->
    $('#status_label').html('Update...')
