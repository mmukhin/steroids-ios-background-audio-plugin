window.echo = function(str, callback) {
    cordova.exec(callback, function(err) {
        callback('Nothing to echo.');
    }, "Echo", "echo", [str]);
};

window.setAVSessionCategory = function(category, callback) {
    cordova.exec(callback, function(err) {
        callback('Something went wrong.');
    }, "AVSession", "setCategory", [category]);
};
