#### 元编程
# madness of meta-programming

### 打开类 open class
class Foo
  def bar
    2
  end
end

# 重新打开类
class Foo
  # 定义新的方法
  def baz
    3
  end

  # 或者覆盖原有的方法(monkey-patch)
end

# 给已有的类，扩充/覆盖方法
# https://github.com/rails/rails/blob/de53ba56cab69fb9707785a397a59ac4aaee9d6f/activesupport/lib/active_support/core_ext/string/inflections.rb

require 'active_support/all'
"dog food".camelcase # => "Dog food"
1.minutes.ago

### 动态调用
"dog food".send(:upcase) # =>"DOG FOOD"  #private方法也可以调用
"dog food".public_send(:upcase) # =>"DOG FOOD"
# 相当于
"dog food".upcase # =>"DOG FOOD"

### 反射
module Greeting
  def greeting
    puts "hello, #{name}"
  end
end

class Account
  include Greeting

  attr_reader :name, :passwd

  @@accounts_repositories = {}

  def initialize(name, passwd)
    @name = name
    @passwd = passwd
  end

  def self.add(account)
    @@accounts_repository[account.name] = account
  end

  def self.find(name)
    @accounts_repositories[name]
  end

  def authenticate(passwd)
    self.passwd == passwd
  end
end

# 列出类里定义的实例方法，类方法
Account.instance_methods
Account.singleton_methods
# 获取, 设置实例上的实例变量
account = Account.new("bob", "111111")
account.instance_variables
account.instance_variable_get(:@name)
account.instance_variable_set(:@passwd, '123456')
# 获取类的继承链
Account.ancestors # => [Account, Greeting, Object, PP::ObjectMixin, Kernel, BasicObject]
Account.included_modules # => [Greeting, PP::ObjectMixin, Kernel]
Account.superclass # => Object

### 动态生成代码
# 创建类，module
# 添加, 删除方法
# 方法别名, 修饰方法
alias_method :new_name, :old_name
alias new_name old_name
# https://www.rubyguides.com/2018/11/ruby-alias-keyword/

# 添加, 删除常量(普通常量，类，模块)
# https://github.com/Talkdesk/talkdesk_main/blob/master/lib/talkdesk/interactors/phones/add_hold_music.rb#L64-L65

### 在类、模块、实例的 context 下执行任意代码
# class_eval
# class_exec
# https://github.com/Talkdesk/talkdesk_main/blob/master/config/initializers/mongoid_objectid.rb

# instance_eval
# instance_exec



### 回调
# module 被 include
module Pet
  def self.included(kls)
    # do anything to kls
    kls.class_eval do
      def eatable?
        false
      end
    end
  end
end

class Cat
  include Pet
end

Cat.new.eatable? # => false

# https://github.com/Talkdesk/talkdesk_main/blob/qa/app/representers/api/pagination_representer.rb#L5-L15

# class 被继承
# 方法未找到 method_missing

class Proxy
  def initialize(target)
    @target = target
  end

  def method_missing(name, *args)
    @target.send(name, *args)
  end
end
str_proxy = Proxy.new("jlksjdf")
puts str_proxy.upcase

# https://github.com/Talkdesk/talkdesk_main/blob/qa/lib/talkdesk/frontend_apps.rb#L17-L25

# 常量(普通常量，类)未找到 const_missing
