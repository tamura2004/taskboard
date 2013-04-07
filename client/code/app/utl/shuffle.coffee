module.exports = shuffle = (array) ->
  i = array.length
  while i
    j = parseInt Math.random() * i
    x = array[--i]
    array[i] = array[j]
    array[j] = x
  array
