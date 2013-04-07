# 初期化
ss = require("socketstream")
Notes = require("/notes")

# DOM参照初期化
colorchip = $ ".colorchips > .colorchip"
main = $ ".main"
trash = $ ".trash"
upload = $ ".upload"
dialog = $ "#dialog"

# カラーチップ定義
colorchip.draggable cursor:"move", helper:"clone", zindex: 2000

# クリック:jQuery->client->server->mongoDB
main.dblclick (e) -> 
  ss.rpc "note.create",
    x: e.pageX
    y: e.pageY
    color: Math.floor(Math.random()*6+1)

main.droppable
  accept: ".colorchips > .colorchip"
  drop: (e,ui) =>
    x = ui.position.left
    y = ui.position.top
    unless Notes.collision(x,y)
      ss.rpc "note.create",
        x: x
        y: y
        color: ui.draggable.attr("id")

# 一括登録定義
dialog.dialog
  autoOpen: false
  height: 380
  width: 300
  modal: true
  buttons:
    "作成": ->
      for text in $(list).val().split(/\n/)
        ss.rpc "note.create",
          x: Math.floor(Math.random()*300+300)
          y: Math.floor(Math.random()*200+200)
          color: Math.floor(Math.random()*6+1)
          text: text
      console.log $(list).val()
      dialog.dialog "close"
    "取消": -> dialog.dialog "close"


# 一括登録イベント処理
upload.button().click ->
  dialog.dialog("open")

# server->client->jQuery
ss.event.on "create", (note) ->
  Notes.create JSON.parse note

# ゴミ箱へのドラッグアンドドロップで削除
trash.droppable
  accept: ".note"
  hoverClass: "trash-active"
  drop: (e,ui) ->
    ss.rpc "note.remove", ui.draggable.attr("id")

ss.event.on "remove", (id) ->
  console.log id
  console.log Notes[id]
  Notes[id].remove()

ss.event.on "update", (note) ->
  console.log JSON.parse note
  Notes.update JSON.parse note

# text change[済]


# color change(font-size)
# drag & drop create
# dialog create

# member name note
# another layout
# background change

# history
# new
# disconnect
# re-connect

# mocha-test
# attention mark




  #     droppable:
  #       accept: ".colorchip,.fontSizechip"
  #       hoverClass: "memo-active"
  #       drop: (e,ui) ->
  #         if ui.draggable.hasClass("colorchip")
  #           memo.head.css
  #             backgroundColor: ui.draggable.css("color")
  #           memo.body.css
  #             backgroundColor: ui.draggable.css("backgroundColor")
  #         else
  #           memo.body.css
  #             fontSize: ui.draggable.data("fontSize")

  #   # クリックでテキストエリアを編集
  #   memo.body.on "click", (e) ->
  #     $(this).wrapInner("<textarea>")
  #     .find("textarea")
