// Generated by CoffeeScript 1.2.1-pre
var slowAlert, __iced_k;

__iced_k = function() {};

slowAlert = function(w, s, cb) {
  var __iced_deferrals,
    _this = this;
  (function(__iced_k) {
    __iced_deferrals = new iced.Deferrals(__iced_k);
    setTimeout(__iced_deferrals.defer({}), w);
    __iced_deferrals._fulfill();
  })(function() {
    alert(s);
    return cb();
  });
};
