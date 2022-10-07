handler = (event, context) ->
  console.log "EVENT: \n#{JSON.stringify(event, null, 2)}"
  context.logStreamName

module.exports =
  handler
