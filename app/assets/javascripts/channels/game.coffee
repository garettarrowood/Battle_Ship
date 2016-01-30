App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    @printMessage("Waiting for opponent...")

  printMessage: (message) ->
    $('#text-area').empty().append("<p>#{message}</p>")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

    switch data.action
      when "game_ready"
        @printMessage("Game started. Make a move!")
        # App.board stuff - must be another js file
      # when "make_move"
        # save the move to server and render move on opponent's screen



