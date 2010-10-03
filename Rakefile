RAGEL = File.expand_path(File.dirname(__FILE__) + "/ragel")

desc "Build all the ragel"
task :ragel do
  FileList["ragel/*rl"].each do |f|
    sh "ragel -R #{f}"
  end
end

desc "Generate dot files"
task :dot do
  FileList["ragel/*rl"].each do |f|
    out = RAGEL + "/#{File.basename(f, '.rl')}.dot"
    sh "ragel -V -p -o #{out} #{f}"
  end
end

task :default => [:ragel, :dot]
