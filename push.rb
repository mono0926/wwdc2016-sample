require 'grocer'

pusher = Grocer.pusher(
  certificate: "./development_com.mono0926.wwdc2016-sample.pem"
)

notification = Grocer::Notification.new(
  device_token:      "7216d3637327f0db90f9b04bacfb7437671e1070929d928adce567c2293944ac",

  # iOS 9 or earlier
  # alert:             "Hello WWDC 2016 Samples",

  # iOS 10 or later
  alert: {
  	"title": "title",
  	"subtitle": "subtitle",
  	"body": "Hello WWDC 2016 Samples" 
  },
  badge:             1,
  sound:             "Default"
)

pusher.push(notification)
