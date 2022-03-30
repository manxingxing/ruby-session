###### Rails
# https://guides.rubyonrails.org/v6.1/
# https://api.rubyonrails.org/

gem install rails -v 6.1.5

rails new --skip-action-cable \
          --skip-active-storage \
          --skip-action-text \
          --skip-active-job \
          --skip-action-mailer \
          --skip-turbolinks \
          --skip-javascript \
          --skip-jbuilder \
          blog

cd blog
bundle exec rails server

### 项目结构

###
