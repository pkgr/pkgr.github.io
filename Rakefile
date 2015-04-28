require 'tempfile'

desc "Build documentation locally"
task :build do
  sh "bundle exec jekyll build"
end

desc "Release documentation"
task :release => :build do
  sh "git checkout master"
  Dir.mktmpdir do |dir|
    sh "cp -r _site #{dir}"
    sh "rm -rf ./*"
    sh "cp -r #{dir}/_site/* ."
  end
  sh "git add . --all && if ! git diff --staged --exit-code ; then git commit -am 'Update doc' && git push origin master ; fi"
  sh "git checkout source"
end

task default: :build
