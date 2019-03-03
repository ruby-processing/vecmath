require 'java'
require 'vecmath/version'
require 'vecmath.jar'
require 'color_group'
module Vecmath
  Java::Monkstone::JRLibrary.load(JRuby.runtime)
end

java_import 'monkstone.vecmath.GfxRender'
java_import 'monkstone.vecmath.ShapeRender'
