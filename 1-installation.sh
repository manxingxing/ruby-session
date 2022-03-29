### Ruby

# mac 系统自带ruby(和python)

### 多版本管理
# 为什么需要?
# 有项目会指定适用的ruby版本。如果有多个ruby项目分别指定了不同的ruby版本，就需要这样的工具切换当前ruby的版本
# * [rbenv](https://github.com/rbenv/rbenv) 类似python的 pyenv
# * [rvm: ruby version manager](https://rvm.io/)  类似node的 nvm

# 安装 rbenv
brew install rbenv
# 查看帮助
rbenv
# 列出可以安装的版本列表
rbenv install -L
# 查看已安装列表
rbenv versions
# 安装指定版本
rbenv install 2.6.8
# 切换版本
rbenv global 2.7.4
rbenv local 2.6.8

## 一个约定
# 在文件夹下放置一个 .ruby-version 文件，写入希望的ruby版本，
# rbenv/rvm 会在进入文件夹时自动切换到指定版本，离开文件夹时会自动切换回去

### gem command
# ruby 的 package 称为 gem. ruby提供了一个工具管理gem
# gem 命令行工具(类似python的 pip；js 的npm 的一部分功能)

# 查看帮助
gem
# 安装
gem install pry
gem install oj -v 3.7.8
# 列出所有的gems
gem list
# 查看环境配置
gem env

## 仓库
* [rubygems.org](https://rubygems.org/)
* [Ruby China 国内镜像](https://gems.ruby-china.com/)

cat ~/.gemrc

### irb 或 pry: interactive console

# require 'oj'
# h = { 'one' => 1, 'array' => [ true, false ] }
# json = Oj.dump(h)


### bundler: https://bundler.io
## 项目的版本依赖工具(类似npm,yarn的一部分功能，maven,gradle的一部分功能)
# 安装
gem install bundler
bundler -h

## Gemfile 是描述项目依赖的文件(类似js的 package.json, java的pom,build.gradle)
# 会生成一个lock文件，锁定版本(类似js的 yarn.lock)
# https://github.com/Talkdesk/talkdesk_main/blob/master/Gemfile

# 安装所有依赖
bundle install
# 更新某一个gem
bundle update rack
# 在当前Gemfile配置下执行, 只有在Gemfile里列出的gem才能被require
bundle exec <COMMAND>
