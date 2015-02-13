task :build do
  sh "bundle exec jekyll build"
end

task :release => :build do
  dir = Dir.mktmpdir
  sh "git checkout gh-pages"
  sh "cp -r _site #{dir}"
  sh "rm -rf ./*"
  sh "cp -r #{dir}/* ."
  sh "git add ."
  sh "git commit -m 'Update doc'"
  sh "git push origin gh-pages"
end

task default: :build
