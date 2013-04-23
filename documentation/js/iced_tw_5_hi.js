// Generated by IcedCoffeeScript 1.6.2a
var cb_generator, f_list, n_out, nothing, o, w_list;



w_list = ["sun", "rain", "snow", "sleet"];

f_list = ["tacos", "burritos", "pizza", "shrooms"];

o = {};

n_out = 0;

nothing = "<nothing found>";

cb_generator = function(field) {
  n_out++;
  return function(json) {
    o[field] = json;
    if (--n_out === 0) {
      if (o.weather.length && o.food.length) {
        return search("" + o.weather[0] + "+" + o.food[0], function(tweets) {
          var msg, _ref;
          msg = (_ref = tweets[0]) != null ? _ref.text : void 0;
          return alert(msg != null ? msg : nothing);
        });
      } else {
        return alert(nothing);
      }
    }
  };
};

rankPopularity(w_list, cb_generator("weather"));

rankPopularity(f_list, cb_generator("food"));
