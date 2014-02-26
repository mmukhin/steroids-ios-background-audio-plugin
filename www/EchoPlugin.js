window.setAVSessionCategory = function(category, callback) {
    cordova.exec(callback, function(err) {
        callback('Something went wrong.');
    }, "AVSession", "setCategory", [category]);
};
