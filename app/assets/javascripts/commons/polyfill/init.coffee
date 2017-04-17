if !Array::find
  Array::find = (predicate) ->
    if this == null
      throw new TypeError('Array.prototype.find called on null or undefined')
    if typeof predicate != 'function'
      throw new TypeError('predicate must be a function')
    list = Object(this)
    length = list.length >>> 0
    thisArg = arguments[1]
    value = undefined
    i = 0
    while i < length
      value = list[i]
      if predicate.call(thisArg, value, i, list)
        return value
      i++
    undefined
