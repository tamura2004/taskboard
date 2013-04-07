Note = require "/note"
# 付箋コレクション
Notes = 
  create: (options)->
    @[options._id] = new Note(options)

  remove: (id) -> @[id].remove()
  
  update: (note) ->
    console.log "in Notes update"
    console.log note
    console.log note._id
    @[note._id].update(note)

  collision: (x,y) ->
    flag = false
    for id,note of Notes
      if note.x - 36 < x < note.x + note.w and note.y - 12 < y < note.y + note.h
        flag = true
    flag

# コレクションをmongoDBから初期化
ss.rpc "note.find", visible:true, (docs) =>
  Notes[doc._id] = new Note doc for doc in JSON.parse docs

# エクスポート
module.exports = Notes
