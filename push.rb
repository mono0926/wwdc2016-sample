require 'grocer'

pusher = Grocer.pusher(
  certificate: "./development_com.mono0926.wwdc2016-sample.pem"
)

notification = Grocer::Notification.new(
  device_token:      "c9e8bacc37261688c9d0fdf0421e915418bbcf559b84482aef629a5afddbf6bc",

  # iOS 9 or earlier
  # alert:             "Hello WWDC 2016 Samples",

  # iOS 10 or later
  alert: {
  	"title": "title",
  	"subtitle": "subtitle",
  	"body": "Hello WWDC 2016 Samples" 
  },
  badge:             1,
  sound:             "Default",
  identifier: 1223
)

pusher.push(notification)
