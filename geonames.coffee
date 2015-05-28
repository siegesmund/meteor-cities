GeoNamesCities = new Mongo.Collection 'data-geonames-cities'

class GeoNames

  update: () ->

    # Last modified timestamp is in central european time

    url = 'http://download.geonames.org/export/dump/cities1000.zip'

    request = Npm.require 'request'
    JSZip = Npm.require 'jszip'

    response = Async.runSync (done) ->
      request {method: 'GET', url: url,encoding: null}, (error, response, body) ->
        if error or response.statusCode isnt 200
          done null, null
        zip = new JSZip body
        done null, zip.file('cities1000.txt').asText()

    fields = ['geonameId', 'name', 'asciiname', 'alternateNames', 'latitude',
              'longitude', 'featureClass', 'featureCode', 'countryCode',
              'cc2', 'admin1Code', 'admin2Code', 'admin3Code', 'admin4Code',
              'population', 'elevation', 'dem', 'timezone', 'modificationDate']

    data = _.map response.result.split('\n'), (row) ->
      row = _.object fields, row.split('\t')
      row.geonameId = parseInt(row.geonameId)
      row.geometry =
        type: 'Point'
        coordinates: [parseFloat(row.longitude), parseFloat(row.latitude)]
      delete row.longitude
      delete row.latitude
      GeoNamesCities.upsert {_id: row.geonameId}, row

    return data
