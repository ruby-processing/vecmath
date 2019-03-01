require 'fileutils'
project 'vecmath', 'https://github.com/ruby-processing/vecmath' do

  model_version '4.0.0'
  id 'ruby-processing:vecmath', '0.3.0'
  packaging 'jar'

  description 'vecmath for Visor etc'

  organization 'ruby-processing', 'https://ruby-processing.github.io'

  developer 'monkstone' do
    name 'Martin Prout'
    email 'mamba2928@yahoo.co.uk'
    roles 'developer'
  end

  issue_management 'https://github.com/ruby-processing/vecmath/issues', 'Github'

  source_control(
    url: 'https://github.com/ruby-processing/vecmath',
    connection: 'scm:git:git://github.com/ruby-processing/vecmath.git',
    developer_connection: 'scm:git:git@github.com/ruby-processing/vecmath.git'
  )

  properties(
    'maven.compiler.source' => '1.8',
    'project.build.sourceEncoding' => 'UTF-8',
    'maven.compiler.target' => '1.8',
    'polyglot.dump.pom' => 'pom.xml',
    'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
    'jruby.api' => 'http://jruby.org/apidocs/'
  )

  pom 'org.jruby:jruby:9.2.6.0'
  jar 'org.processing:core:3.3.7'

  plugin_management do
    plugin :resources, '2.6'
    plugin :dependency, '2.8'
    plugin(
      :compiler, '3.8.0',
      source: '${maven.compiler.source}',
      target: '${maven.compiler.target}'
    )
    plugin(
      :javadoc, '2.10.4',
      detect_offline_links: 'false',
      links: ['${processing.api}', '${jruby.api}']
    )
  end
  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'vecmath'
  end
end
