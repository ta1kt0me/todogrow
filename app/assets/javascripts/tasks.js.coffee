# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ajax:success', '#task-modal', (xhr, data, status) ->
  location.reload()

$(document).on 'ajax:error', '#task-modal', (xhr, data, status) ->
  modalError(data)

$('a[id^="edit-task-"]').on 'ajax:success', (xhr, data, status) ->
  initModal()
  $('#task-modal #task-id')[0].value        = data.id
  $('#task-modal #task-name')[0].value      = data.name

  # TODO deadlineのフォーマット
  $('#task-modal #datetimepicker')[0].value = if data.deadline? then moment().format('YYYY/MM/DD hh:mm', data.deadline) else ''

  # execute update
  $('form').attr('action','/tasks/' + data.id)
  $('form').attr('method','PUT')

$('a[id^="edit-task-"]').on 'ajax:error', (xhr, data, status) ->
  modalError(data)

$('a[id^="close-task-"]').on 'ajax:success', (xhr, data, status) ->
  $("div#task-#{data.id}").remove()

$('a[id^="close-task-"]').on 'ajax:error', (xhr, data, status) ->
  console.log 'close!!!'
  console.log data
  $divAlert = $('<div id="close-task-errors" class="alert alert-danger"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button></div>')
  $div  = $('<div></div>')
  data.responseJSON.messages.forEach (message, i) ->
    $p = $('<p></p>').text(message)
    $div.append($p)

  if $('#close-task-errors')[0]
    $('#close-task-errors').html(ul)
  else
    $divAlert.append($div)
    $('div#main-content').prepend($divAlert)

$('#create-new-task').on click:->
  initModal()

  # execute create
  $('form').attr('action','/tasks')
  $('form').attr('method','POST')

$('a[id^="edit-task-"]').on click:->
  $('form').attr('path')

modalError = (data)->
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

initModal = ->
  $('#task-name')[0].value = ''
  $('#datetimepicker')[0].value = ''
  $('#create-task-errors').remove()
