# jquery要素
HtmlEvent = require "/htmlevent"

# 付箋クラス
class Note extends HtmlEvent
  constructor: (options)->
    super options

  update: (options) ->
    @html.remove()
    @html.appendTo "ul.notes"
    super
    @setevent()

  remove: ->
    @html.animate top: 520
    @html.animate left: 924
    @html.animate opacity: 0, 400, "swing", -> @remove()

module.exports = Note