#### 元编程

### 再次回忆rubyVM 里有什么
# * 一个由嵌套的 module, class 组成的树
# * 引用 module，class 时，自顶向下，用 "::" 连接起来
# * 查找时, 自当前位置向上层查找
#   参考 Module.nesting 的返回结果
# * 前置的"::"表示从顶层开始查找
#   talkdesk_main 里有很多例子
# * 类包含 类方法(静态方法)，实例方法，实例变量

### 元编程的含义
# * 通过反射的方法，获取rubyVM里的对象
# * 用代码生成代码，操作rubyVM里的对象

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
"dog food".upcase # =>"DOG FOOD"
# "dog food".send(:upcase) # =>"DOG FOOD"  # private方法也可以调用
"dog food".public_send(:upcase) # =>"DOG FOOD"

# https://github.com/Talkdesk/talkdesk_main/blob/master/app/representers/api/pagination_representer.rb#L6-L13

### 反射
module Greeting
  def greeting
    puts "hello, #{name}"
  end
end

class Account
  include Greeting

  NOT_FOUND_ERROR = "账号未找到"

  attr_reader :name, :passwd

  @@accounts_repository = {}

  def initialize(name, passwd)
    @name = name
    @passwd = passwd
  end

  def self.add(account)
    @@accounts_repository[account.name] = account
  end

  def self.find(name)
    @@accounts_repository[name] || raise(NOT_FOUND_ERROR)
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
account.is_a?(Account)
account.instance_of?(Account)
account.respond_to?(:authenticate)
# 常量
Account.constants
Account.const_get(:NOT_FOUND_ERROR)
Account.const_set(:NOT_FOUND_ERROR, "Account not found")
Account.send(:remove_const, :NOT_FOUND_ERROR)

# https://github.com/Talkdesk/talkdesk_main/blob/qa/lib/talkdesk/interactors/phones/add_hold_music.rb#L64-L65

# 获取类的继承链
Account.ancestors # => [Account, Greeting, Object, PP::ObjectMixin, Kernel, BasicObject]
Account.included_modules # => [Greeting, PP::ObjectMixin, Kernel]
Account.superclass # => Object

### 动态生成代码
# 创建类，module
# https://github.com/Talkdesk/talkdesk_main/blob/qa/lib/talkdesk/errors.rb#L2

# 添加, 删除方法
# 添加, 删除常量(普通常量，类，模块)

### 在类、模块、实例的 context 下执行任意代码
# class_eval
# class_exec

# https://github.com/Talkdesk/talkdesk_main/blob/master/config/initializers/mongoid_objectid.rb

# instance_eval
# instance_exec
# https://github.com/Talkdesk/talkdesk_main/blob/qa/app/representers/api/pagination_representer.rb#L20-L35

# 方法别名, 修饰方法
alias_method :new_name, :old_name
alias new_name old_name
# https://www.rubyguides.com/2018/11/ruby-alias-keyword/



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
