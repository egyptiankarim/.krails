# Basic setup stuff.
application "config.app_name = \"#{ARGV[1]}\""

gem_group :production, :staging do
  gem 'mysql2'
end

generate(:controller, "welcome index")
route "root to: 'welcome#index'"

generate(:controller, "about index")
route "get 'about', to: 'about#index', as: :about"

rake "db:migrate"
rake "routes" 

run "cap install"

# Do all the file copying.
def source_paths
  [File.join(File.expand_path(File.dirname(__FILE__)),'krails_root')] + Array(super)
end

inside 'config' do
  inside 'initializers' do
    remove_file 'assets.rb'
    copy_file 'assets.rb'
  end
end

inside 'vendor' do
  inside 'assets' do
    inside 'fonts' do
      copy_file 'glyphicons-halflings-regular.eot'
      copy_file 'glyphicons-halflings-regular.ttf'
      copy_file 'glyphicons-halflings-regular.svg'
      copy_file 'glyphicons-halflings-regular.woff'
    end
    inside 'images' do 
    end
    inside 'javascripts' do
      copy_file 'bootstrap.js'
    end
    inside 'licenses' do
      copy_file 'bootstrap.txt'
    end
    inside 'stylesheets' do
      copy_file 'bootstrap.css'
      copy_file 'bootstrap.css.map'
    end
  end
end

inside 'lib' do
  inside 'assets' do
    inside 'images' do
      copy_file 'Domo.png'
      copy_file 'Octocat.png'
    end
    inside 'stylesheets' do
      copy_file 'bootstrap-fonts-correct.scss'
      copy_file 'images.css'
      copy_file 'sticky-footer-navbar.css'
      copy_file 'typography.css.scss'
    end
  end
end

inside 'app' do
  inside 'assets' do
    inside 'javascripts' do
      remove_file 'application.js'
      copy_file 'application.js'
    end
    inside 'stylesheets' do
      remove_file 'application.css'
      copy_file 'application.css'
    end
  end
  inside 'helpers' do
    remove_file 'application_helper.rb'
    copy_file 'application_helper.rb'
  end
  inside 'views' do
    inside 'layouts' do
      remove_file 'application.html.erb'
      copy_file 'application.html.erb'
    end
    inside 'shared' do
      copy_file '_foot.html.erb' 
      copy_file '_head.html.erb'  
      copy_file '_lorem.html.erb'  
      copy_file '_nav.html.erb'
    end
    inside 'welcome' do
      remove_file 'index.html.erb'
      copy_file 'index.html.erb'
    end
    inside 'about' do
      remove_file 'index.html.erb'
      copy_file 'index.html.erb'
    end
  end
end

# Setup a repository.
after_bundle do
  git :init
  git add: "-A ."
  git commit: "-m 'Initial commit'"
end
