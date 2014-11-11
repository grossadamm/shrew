/* jshint: asi:false */
(function(config) {
  var _validConfig = function(){
    if(typeof config.pageViewUrl !== 'string'){
      return false
    }
    if(typeof config.jTI !== 'string'){
      return false
    }
    return true
  }

  /* http://stackoverflow.com/questions/8790099/detect-if-any-javascript-function-is-running */
  var automaticallyTrackPageView = function() {
    if (window.addEventListener) {
      window.addEventListener("load", loadHandler, false)
    }
    else if (window.attachEvent) {
      window.attachEvent("onload", loadHandler)
    }
    else {
      window.onload = loadHandler
    }

    function loadHandler() {
      setTimeout(trackPageView, 0)
    }
  }

  var trackPageView = function() {
    if(!_validConfig()){
      if(typeof console !== 'undefined' && typeof console.error !== 'undefined'){
        console.error('invalid analytics configuration')
      }
      return false
    }
    var xmlhttp = new XMLHttpRequest()
    var params = 'url=' + encodeURIComponent(window.location.href) +
                 '&title=' + encodeURIComponent(document.title) +
                 '&jTI=' + encodeURIComponent(config.jTI) + 
                 '&jRT=' + encodeURIComponent(new Date().getTime())
    params.replace(/%20/g, '+')
    xmlhttp.open('POST', config.pageViewUrl, true)
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded')
    xmlhttp.send(params)
  }

  var setJTI = function(jTI){
    config.jTI = jTI
  }

  var publicAccess = {
    automaticallyTrackPageView: automaticallyTrackPageView,
    trackPageView: trackPageView,
    setJTI: setJTI,
    config: config
  }

  if ( typeof define === "function" && define.amd ) {
    define([], function(){
      return publicAccess
    })
  } else {
    window.analytics = publicAccess
  }
})(typeof analyticsConfig !== 'undefined' ? analyticsConfig : {
  pageViewUrl: '/analytics/page_views',
  jTI: null
})