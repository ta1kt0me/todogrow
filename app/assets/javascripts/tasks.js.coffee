# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ajax:success', '#task-modal', (xhr, data, status) ->
  location.reload()

$(document).on 'ajax:error', '#task-modal', (xhr, data, status) ->
  modalError(data)

$('a[id^="edit-task-"]').on 'ajax:success', (xhr, data, status) ->
  initModal()
  console.log data
  $('#task-modal #task-id')[0].value        = data['task'].id
  $('#task-modal #task-name')[0].value      = data['task'].name

  $('#task-modal #datetimepicker')[0].value = if data['task'].deadline? then moment(data['task'].deadline).format('YYYY/MM/DD hh:mm') else ''

  # execute update
  $('form').attr('action','/tasks/' + data.id)
  $('form').attr('method','PUT')

$('a[id^="edit-task-"]').on 'ajax:error', (xhr, data, status) ->
  modalError(data)

$('a[id^="close-task-"]').on 'ajax:success', (xhr, data, status) ->
  $("div#task-#{data.id}").remove()

$('a[id^="close-task-"]').on 'ajax:error', (xhr, data, status) ->
  $divAlert = $('<div id="close-task-errors" class="alert alert-danger"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button></div>')
  $div      = $('<div></div>')
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

$('#add-new-tag').on click:->
  addNewTag()

$('input#new-tag-text').on keypress: (e) ->
  if !e
    e = window.event
  if e.keyCode == 13
    addNewTag()
    false

$('span.task-tag').on click: ->
  setSelectTagEvent($(this))

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
  $('#new-tag-text')[0].value = ''
  $('div#enable-tag-list input[id^="tag-"]:checked').attr("checked", false)
  $('div#enable-tag-list span.selected-tag').addClass('label-default').removeClass('selected-tag label-success')

  # $('#task-have_tags')[0].value = new Array()

addNewTag = ->
  newTagName = $('input#new-tag-text').val()
  $('input#new-tag-text').val('')

  $input = $("<input id='tag-#{newTagName}' name='task[tag_list][]' style='display:none;' type='checkbox' value='#{newTagName}'>")
  $label = $("<label for='tag-#{newTagName}'>")
  $span  = $('<span class="label label-default fa pull-left task-tag" style="margin-bottom:5px;">')
  $span.text("#{newTagName}").on click: ->
    setSelectTagEvent($(this))


  $label.append($span)
  $('div#enable-tag-list').append($input).append($label)

setSelectTagEvent = ($elem) ->
  if $elem.hasClass('selected-tag')
    $elem.addClass('label-default')
    $elem.removeClass('selected-tag label-success')
  else
    $elem.addClass('selected-tag label-success')
    $elem.removeClass('label-default')