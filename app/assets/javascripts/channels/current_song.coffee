App.current_song = App.cable.subscriptions.create 'CurrentSongChannel',

  connected: ->
    console.log 'Got here. Connected'
    return

  disconnected: ->
    console.log 'disconnected'
    return

  received: (data) ->
    console.log 'received mehtod here'
    console.log data
    song = $('#song-playing')
    song.html data['song']
    
    return

  #
  #
  # play: (song) ->
  #   console.log 'play method here'
  #   console.log songc
  #   @perform 'play', data: song


#
#
#     console.log 'Received function'
#     console.log 'This is what is going through the channel:' + data['song']
#     song = $('#song-playing')
#     song.html data['song']
#     return
# )


# // $(document).on 'change', '[data-behavior~=room_speaker]', (event) ->
# //   if event.keyCode is 13 #return = send
# //     App.room.speak event.target.value
# //     event.target.value = ''
# //     event.preventDefault()
# // $(document).change(function(event) {
# //  App.current_song.set(event.state)
# // });
