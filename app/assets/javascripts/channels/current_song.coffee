App.current_song = App.cable.subscriptions.create 'CurrentSongChannel',


  received: (data) ->
    console.log 'received method here with their data:'
    console.log data
    song = $('#song-playing')
    song.html data['song']
    # $('#currently-playing-song').removeClass 'hidden'
    # $('[data-current-party=\'' + data.current_party + '\']').append data.song
    return
  #
  # play: (song) ->
  #   console.log 'play method here'
  #   console.log song
  #   @perform 'play', song: song
  #


  connected: ->
    console.log 'Got here. Connected'
    return

  disconnected: ->
    console.log 'disconnected'
    return





# // $(document).on 'change', '[data-behavior~=room_speaker]', (event) ->
# //   if event.keyCode is 13 #return = send
# //     App.room.speak event.target.value
# //     event.target.value = ''
# //     event.preventDefault()
# // $(document).change(function(event) {
# //  App.current_song.set(event.state)
# // });
