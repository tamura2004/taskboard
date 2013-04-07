# 親クラス
Html = require "/html"

# イベント定義
class HtmlEvent extends Html
  constructor: (options)->
    super options
    @setevent()

  setevent: ->
    # ドラッグで位置情報更新可能に
    @html.draggable
      opacity: 0.5
      zIndex: 1000
      stop: (event,ui) =>
        if ui.position.left < 900
          ss.rpc "note.update", @_id,
            x: ui.position.left
            y: ui.position.top

    @html.css position: "absolute" # 副作用をリセット

    # 付箋のダブルクリックで編集
    @html.dblclick =>
      textarea = @html.wrapInner("<textarea>").find("textarea")
      textarea.focus().select().blur =>
        text = textarea.val().replace /\n/g, "<br>"
        @html.html text # textareaタグごと入力テキストで上書き
        ss.rpc "note.update", @_id, text: text

    # カラーチップのドロップで色変更
    @html.droppable
      accept: ".colorchips > .colorchip"
      hoverclass: "note-active"
      drop: (e,ui) =>
        e.stopImmediatePropagation()
        color = ui.draggable.attr("id")
        ss.rpc "note.update", @_id, color: color

module.exports = HtmlEvent