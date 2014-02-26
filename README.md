Steroids iOS background audio plugin
====================

##Usage

Sets AVSession category to AVAudioSessionCategoryPlayback. To enable background audio on iOS.

```
window.setAVSessionCategory("AVAudioSessionCategoryPlayback", function(str) {
    alert(echoValue == "Done setting AVAudioSessionCategoryPlayback."); // should alert true.
});
```

NB: this method is hard-coded to use only AVAudioSessionCategoryPlayback. Must haxor further to enable other categories.
