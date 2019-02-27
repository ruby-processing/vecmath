require 'java'
require 'vecmath/version'
require 'vecmath.jar'


module Vecmath
  Java::Monkstone::JRLibrary.load(JRuby.runtime)
end
