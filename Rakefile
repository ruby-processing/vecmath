require 'rake'

desc 'Build gem'
task :gem do
  sh 'gem build vecmath.gemspec'
end

desc 'Compile'
task :compile do
  sh 'mvn package'
  sh 'mv target/vecmath.jar lib'
end

desc 'clean'
task :clean do
  Dir["./**/*.{jar,gem}"].each do |path|
    puts "Deleting #{path} ..."
    File.delete(path)
  end
  FileUtils.rm_rf('./target')
end

task default: [ :compile, :gem]
