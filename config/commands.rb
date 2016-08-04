require 'toy/interpreter'
require 'toy/position'

Toy::Interpreter.configure do

  match /^MOVE$/,   to: '#move'
  match /^LEFT$/,   to: '#left'
  match /^RIGHT$/,  to: '#right'
  match /^REPORT$/, to: '#report'
  match /^PLACE (\d+),(\d+),(#{Toy::Position.directions.join("|")})$/, to: '#place'

end
