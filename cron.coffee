if Meteor.isServer

  SyncedCron.add
    name: 'Update GeoNames'

    schedule: (parser) ->
      return parser.recur().onWeekday().on('5:00:00').time()

    job: -> geonames = new GeoNames(); geonames.update()
