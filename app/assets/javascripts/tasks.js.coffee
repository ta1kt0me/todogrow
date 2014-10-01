# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ajax:success', '#task-modal', (xhr, data, status) ->
  location.reload()

$(document).on 'ajax:error', '#task-modal', (xhr, data, status) ->
  form = $('#task-modal .modal-body')
  div  = $('<div id="create-task-errors" class="alert alert-danger"></div>')
  ul   = $('<ul></ul>')
  data.responseJSON.messages.forEach (message, i) ->
    li = $('<li></li>').text(message)
    ul.append(li)

  if $('#create-task-errors')[0]
    $('#create-task-errors').html(ul)
  else
    div.append(ul)
    form.prepend(div)

$('#create-new-task').on click:->
  $('#task-name')[0].value = ''
  $('#datetimepicker')[0].value = ''


