desc 'Combine git add, commit and push with a message'
task :push_changes, [:commit_message] do |t, args|
  sh "git add ."
  sh "git commit -m '#{args[:commit_message]}'"
  sh "git push"
end
