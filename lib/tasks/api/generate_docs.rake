namespace :api do
  desc "Regenerate documentation"
  task :generate_docs do
    sh "apidoc -i ./app/controllers/api -o public/api_docs"
  end
end
