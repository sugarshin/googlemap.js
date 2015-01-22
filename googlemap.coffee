extend = require 'node.extend'

class GoogleMap
  "use strict"

  _defaults:
    id: 'id'
    lalo: null
    output: 'output'
    markerImage: ''

  constructor: (opts) ->
    @opts = extend {}, defaults, opts
    @events()

  initialize: ->
    featureOpts = [
      'stylers': [
        'hue': ''
      ]
      'elementType': ''
      'featureType': ''
    ]

    mapOptions =
      zoom: 16
      center: @opts.lalo
      zoomControl: false
      scaleControl: false
      panControl: false
      streetViewControl: false
      overviewMapControl: false
      mapTypeControl: false

    styledMapOptions =
      name: @opts.id

    map = new google.maps.Map document.getElementById(@opts.output), mapOptions

    marker = new google.maps.Marker(
      position: @opts.lalo
      map: map
      icon: @opts.markerImage
    )

    customMapType = new google.maps.StyledMapType featureOpts, styledMapOptions

    map.mapTypes.set @opts.id, customMapType

    return this

  events: ->
    google.maps.event.addDomListener window, 'load', => @initialize()
    return this

if typeof define is 'function' and define.amd
  define -> GoogleMap
else if typeof module isnt 'undefined' and module.exports
  module.exports = GoogleMap
else
  global.GoogleMap or= GoogleMap
