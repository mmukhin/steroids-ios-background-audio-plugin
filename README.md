AVSession plugin
====================

##Purpose

Sets AVSession category to AVAudioSessionCategoryPlayback. This is to enable background audio on iOS.

##Status

This plugin is unfinished and only put together as a hack on github (mostly edited in the browser!). #worksforme

##Usage

Example below in Coffeescript.

```
  $scope.tackleIOSAVSession = ->
    console.log 'setting AVSession on iOS...'    
    onSuccess = (str) ->
      console.log('Set the AVSession on iOS: ' + str)
    onError = (err) ->
      console.log('Unable to set iOS audio session')
    cordova.exec(onSuccess, onError, "AVSession", "setCategory", ['AVAudioSessionCategoryPlayback'])

```

NB: the setCategory method is hard-coded to use only AVAudioSessionCategoryPlayback. It would be quite trivial to enable other categories by actually using the argument supplied to the method.
