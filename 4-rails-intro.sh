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

### MVC

## routing
# * 每条路由规则由三个部分组成
# 1. 网址
# 2. controller#action
# 3. 规则名称. 会自动生成 *_url, *_path 方法

# https://guides.rubyonrails.org/v6.0/routing.html
# root
# match
# get, post, ...
# resources, resource
# scope: module, controller, path, as

bundle exec rails routes

# 例子:
# https://github.com/Talkdesk/talkdesk_main/blob/6a2a6bb743e52099865d4568c61ea496a2fcdcf2/app/representers/api/callbar/voicemail_drop_message_document_representer.rb#L22
# https://github.com/Talkdesk/talkdesk_main/blob/master/app/controllers/application_controller.rb#L58

## controller
# https://guides.rubyonrails.org/v6.0/action_controller_overview.html

# 接受请求参数
# params
# request.headers
# request.env

# 返回响应
# render

## model
# ORM: https://www.mongodb.com/docs/mongoid/current/tutorials/mongoid-documents/
