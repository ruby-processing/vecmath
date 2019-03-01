require 'java'
require 'vecmath/version'
require 'vecmath.jar'


module Vecmath
  Java::Monkstone::JRLibrary.load(JRuby.runtime)
end

java_import 'monkstone.vecmath.AppRender'
java_import 'monkstone.vecmath.ShapeRender'
java_import 'monkstone.ColorUtil'
