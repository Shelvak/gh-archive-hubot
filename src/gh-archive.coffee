# Description:
#   Gh-Arch daily reporter
#
# Dependencies:
#   jsdom
#
# Configuration:
#   None
#
# Commands:
#   gh-archive
#
# Author:
#   Nestor Coppi

jsdom = require('jsdom').jsdom
jquery = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'
url = 'http://us5.campaign-archive2.com/home/?u=439aa16a39e4b10e0b65ff2ef&id=0b82fec5c2'

module.exports = (robot) ->
  robot.hear /gh-archive/i, (msg) ->
    jsdom.env url, [jquery], (errors, window) ->
      (($) ->
        one_day_miliseconds = 24 * 3600 * 1000
        date = new Date(new Date - one_day_miliseconds)
        yesterday = [date.getMonth() + 1, date.getDate(), date.getFullYear()].join('/')
        link = $("li:contains(\"#{yesterday}\") a").attr('href')

        msg.send "Github-Archive report for #{yesterday}"

        msg.send if link then link else 'Doesn\'t have report'
      )(window.jQuery)
