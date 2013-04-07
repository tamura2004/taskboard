# jquery要素ファクトリ

class Html
  constructor: (options) ->
    # 名前つきパラメータを受領
    {@x,@y,@w,@h,@color,@text,@_id} = options

    # デフォルト値をセット
    @w ?= 50; @h ?= 35;
    @color ?= Math.floor(Math.random()*6+1)

    # jQueryオブジェクト(=DOM)関連操作
    @html = jQuery ss.tmpl.note.render()
    @html.attr "id", @_id
    @html.appendTo "ul.notes"
    @update @

  update: (options) ->
    for key,value of options
      if key in ["x","y","w","h","color","text"] and value?
        @[key] = value

    @html.animate left: @x
    # @html.html ""
    @html.html @text
    @html.lettering().animateLetters
      top: 50
      left: 100
      opacity: 0
    ,
      null
    ,
      randomOrder: false
      time: 500
      reset: true
    
    @html.animate top: @y
    @html.animate width: @w
    @html.animate height: @h
    
    @html.removeClass("color1 color2 color3 color4 color5 color6").addClass "color#{@color}" #旧色削除なし＝手抜き




module.exports = Html