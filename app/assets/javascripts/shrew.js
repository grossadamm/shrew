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

  var _localStorageAvailable = (function() {
    var mod = 'localStorage';
    try {
        localStorage.setItem(mod, mod);
        localStorage.removeItem(mod);
        return true;
    } catch(e) {
        return false;
    }
  })();


  var _bindClick = function() {
    if (window.addEventListener) {
      window.addEventListener("click", clickHandler, false);
    } // ignore old ie....

    function clickHandler(e) {
      var x = e.clientX,
          y = e.clientY,
          body = document.body,
          html = document.documentElement;

      var height = Math.max( body.scrollHeight, body.offsetHeight, 
                             html.clientHeight, html.scrollHeight, html.offsetHeight );

      var width = Math.max ( body.clientWidth, html.clientWidth, window.innerWidth );

      params = {
        url: window.location.href,
        jTI: config.jTI,
        x: x,
        y: y,
        height: height,
        width: width
      };
      params = _buildParamsString(params);
      _saveClick(params);
    }
  };

  var _saveClick = function(params) {
    var clicks = localStorage.getItem(config.localStorageClickTrackingKey);
    if(clicks === null) {
      clicks = [];
    } else {
      clicks = JSON.parse(clicks);
    }
    clicks.push(params);
    localStorage.setItem('shrewClicks', JSON.stringify(clicks));
  };

  var _sendClicks = function() {
    var clicks = localStorage.getItem(config.localStorageClickTrackingKey);
    if(clicks === null) {
      clicks = [];
    } else {
      clicks = JSON.parse(clicks);
    }
    if(clicks.length > 0) {
      click = clicks[0];
      _sendRequest(click, config.pageClickTrackingUrl, function() {
        clicks.shift();
        localStorage.setItem(config.localStorageClickTrackingKey, JSON.stringify(clicks));
        _sendClicks();
      });
    }
  };

  var _buildParamsString = function(params) {
    key = Object.keys(params)[0];
    paramsString = key + '=' + encodeURIComponent(params[key]);
    for(var i = 1; i < Object.keys(params).length; i++) {
      key = Object.keys(params)[i];
      paramsString = paramsString + '&' + key + '=' + encodeURIComponent(params[key]);
    }
    paramsString.replace(/%20/g, '+');
    return paramsString;
  };

  /* http://stackoverflow.com/questions/8790099/detect-if-any-javascript-function-is-running */
  var automaticallyTrackPageView = function() {
    if (window.addEventListener) {
      window.addEventListener("load", loadHandler, false);
    }
    else if (window.attachEvent) {
      window.attachEvent("onload", loadHandler);
    }
    else {
      window.onload = loadHandler;
    }

    function loadHandler() {
      setTimeout(trackPageView, 0);
    }
  };

  var _sendRequest = function(params, url, requestListener) {
    if(typeof requestListener === 'undefined') {
      requestListener = function() {};
    }
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open('POST', url, true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlhttp.onload = requestListener;
    xmlhttp.send(params);
  };

  var trackPageView = function() {
    if(!_validConfig()){
      if(typeof console !== 'undefined' && typeof console.error !== 'undefined'){
        console.error('invalid shrew configuration');
      }
      return false;
    }

    var params = {
      url: window.location.href,
      title: document.title,
      jTI: config.jTI,
      jRT: new Date().getTime()
    };
    params = _buildParamsString(params);
    _sendRequest(params, config.pageViewUrl);
  };

  var setJTI = function(jTI){
    config.jTI = jTI;
  };

  if(config.clickTracking && _localStorageAvailable) {
    _bindClick();
    _sendClicks();
  }

  var publicAccess = {
    automaticallyTrackPageView: automaticallyTrackPageView,
    trackPageView: trackPageView,
    setJTI: setJTI,
    config: config
  };

  if ( typeof define === "function" && define.amd ) {
    define([], function(){
      return publicAccess;
    });
  } else {
    window.shrew = publicAccess;
  }
})(typeof shrewConfig !== 'undefined' ? shrewConfig : {
  pageViewUrl: '/shrew/page_views',
  pageClickTrackingUrl: '/shrew/clicks',
  jTI: null,
  clickTracking: true,
  localStorageClickTrackingKey: 'shrewClicks'
});