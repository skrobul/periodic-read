events = require 'events'
fs = require 'fs'

class PeriodicRead extends events.EventEmitter

  constructor: (@filename, @separator="\n", @interval=500) ->
    @lastPos = fs.statSync(@filename).size
    @bytesRead = 0
    @buffer = ''
    @read()

  read: ->
    fs.stat @filename, (err, stats) =>
      if stats.size > @lastPos
        @bytesRead = 0
        #@emit('read', { start: @lastPos, end: stats.size - 1, encoding: 'utf-8'})
        stream = fs.createReadStream(@filename, { start: @lastPos, end: stats.size - 1, encoding: 'utf-8'})

        stream.on 'error', (error) =>
          @emit('error', error)

        stream.on 'data', (data) =>
          @bytesRead += data.length
          @buffer += data
          parts = @buffer.split(@separator)
          @buffer = parts.pop() # save last segment for next read cycle
          # console.log "READ: #{parts.length} chunks"
          @emit('line', chunk) for chunk in parts

        stream.on 'end', =>
          @lastPos = @lastPos + @bytesRead
          # schedule next read
          setTimeout((=> @read()), @interval)
      #
      # file not changed
      #
      else if stats.size == @lastPos
        setTimeout((=> @read()), @interval)
      #
      # file smaller then previous cycle
      #
      else
        @lastPos = 0
        setTimeout((=> @read()), @interval)

exports.PeriodicRead = PeriodicRead