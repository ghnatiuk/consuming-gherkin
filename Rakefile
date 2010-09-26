desc "Build all the ragel"
task :ragel do
  FileList["ragel/*rl"].each do |f|
    sh "ragel -R #{f}"
  end
end

task :default => :ragel
