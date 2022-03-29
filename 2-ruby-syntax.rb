
##### 常用数据结构

### 字符串
puts 'hello world'
name = 'talkdesk'
puts "hello #{name}"

### Symbol
# 针对字符串的一种优化，所有相同的symbol在内存里只有一份
# 类似的思想: java 缓存了 (-128 to 127) 的Integer
puts "hello".object_id
puts "hello".object_id
puts :hello.object_id
puts :hello.object_id
puts "hello" == :hello
puts :hello == :hello

# https://twitter.com/yukihiro_matz/status/916083723589656576?ref_src=twsrc%5Etfw%7Ctwcamp%5Etweetembed%7Ctwterm%5E916083723589656576%7Ctwgr%5E%7Ctwcon%5Es1_&ref_url=https%3A%2F%2Fblog.arkency.com%2Fcould-we-drop-symbols-from-ruby%2F

### Array 数组
# 类似 js的数组
listA = [1,2,2.3, "a string"]

# 用 * 展开一个数组
# 类似js的 ...
listB = [1, 2, "string", 23.23, *listA]

## 并行赋值
name, age = ["matz", 56]
name # "matz"
age # 56

# 通过返回一个数组，实现多返回值的效果
# 比js的模式匹配功能要弱很多
def who()
  ["matz", 56]
end

name, age = who()

## Hash
# 类似java 的 LinkedHashMap 结构, js 的 object
matz = {
  name: "matz",
  age: 56
}
matz[:name]
matz[:age]
matz[:age] = 57

matz = {
  "name" => "matz",
  "age" => 56
}
matz["name"]
matz["age"]

# 用 ** 展开一个 hash
# 类似js的 ...
person = {
  **matz,
  gender: "male"
}

### 集合遍历
arr = [1,2,3,4,5]
arr.each { |e| puts e }
arr.each do |e|
  puts e
end

map = {key1: "val1", key2: "val2"}
map.each do |k, v|
  puts "#{k} = #{v}"
end

# 其他方法: map, filter, delete_if....

### block
# {} 或者 do ... end 包裹的代码块
# 可以有参数
# 类似于js的匿名函数

# block是ruby最有特色的语法特点，无处不在

# 两种方式定义可以接受block的方法

# 调用时, block被转换成一个 Proc 类型的对象
def foo(arg1, arg2, &a_block)
  a_block.call(arg1, arg2)
end

def bar(arg1, arg2)
  yield arg1, arg2
end

foo(1,2) { |a, b| a + b }
bar(1,2) { |a, b| a + b }

# symbol to proc
# 适用于无参数的方法
["a", "b", "c"].map(&:upcase) # => ["A", "B", "C"]
["a", "b", "c"].map { |arg| arg.upcase } # same as the above statement

# 实际会调用 Symbol#to_proc 方法
p = :upcase.to_proc
p.call("abc") # => "ABC"


### proc, lambda
sumProc = Proc.new { |arg1, arg2| arg1 + arg2 }
sumProc2 = proc { |arg1, arg2| arg1 + arg2 }
sumLambda = ->(arg1, arg2) { arg1 + arg2 }
sumLambda2 = lambda { |arg1, arg2| arg1 + arg2 }
puts sumProc.call(1,2)
puts sumProc2.call(1,2)
puts sumLambda.call(1,2)
puts sumLambda2.call(1,2)

foo(1,2, &sumProc)
foo(1,2, &sumLambda)

# lambda和proc的区别
# * lambda 里return会退出lambda，proc 里的return会退出所在的方法
# * lambda 调用时会检查参数个数，proc不会

### 方法
def complex_method(arg1, *args, **kargs)
  puts "arg1 = #{arg1}"
  puts "args = #{args}"
  puts "kargs = #{kargs}"
end

complex_method(1, 2, 3, 4, a: 10, b: 1)
# 方法(定义时、调用时)可以省略括号
complex_method 1, 2, 3, 4, a: 10, b: 1

# 最后一个参数是hash时，可以省略 {}
def method_with_hash(options)
  options
end
method_with_hash({configA: "configA", configB: "configB"})
method_with_hash configA: "configA", configB: "configB"

# render status: :forbidden, json: FORBIDDEN_ERROR
# 其实相当于
# render({status: :forbidden, json: FORBIDDEN_ERROR})

## 命名约定
# "?" 结尾的方法，通常返回一个 boolean
# "!" 结尾的方法，可能会修改当前对象，抛出异常，或者做一些值得注意的事情
# "=" 结尾的方法，表示 setter 方法
# 它们都是方法名的组成部分

### control-flow
# * if/unless 可以后置(在某些语境下读的通顺)

def grade(score)
  return 'good' if score >= 4
  return 'normal' if score == 3

  'need improvement'
end


### 常量
# 所有以大些字母开头的，都是常量!!(类也是常量)
# 定义后仍然可以修改，只是产生一个warning(一般不会乱改的啦...)

# * 普通常量
# * 类
# * module

A_CONSTANT = "a constant"

module OuterModule
  class OuterClass
    CONSTANT = "outerClass"
  end

  module InnerModule
    class InnerClass
      CONSTANT = "InnerClass in InnerModule"
    end

    puts OuterClass::CONSTANT
  end

  module InnerModule2
    class InnerClass2
      CONSTANT = "InnerClass2 in InnerModule2"

      puts InnerModule::InnerClass::CONSTANT
    end
  end
end

# 互相嵌套的module/class 构成一个大的常量树。整个解释器环境就是一个大的常量树
# 常量查找过程: https://cirw.in/blog/constant-lookup.html

### 类
# < 表示继承。ruby只支持单继承，不支持接口
class Dog < Animal
  # 没有java那样的字段声明

  # 批量定义 getter, setter
  # attr_reader :name
  # attr_writer :name
  attr_accessor :name
  # 相当于定义了
  # def name
  #   @name
  # end
  # def name=(newName)
  #   @name = newName
  # end

  # 以两个 @@ 开头的是类变量，类似java的静态变量
  @@class_variable = "this is class variable"

  # 类似java 的 static final 字段
  CONSTANT_A = "A constant"

  # 构造方法
  def initialize(name)
    # 以 @ 开头的变量是实例变量，只属于当前实例
    @name = name
  end

  # 类方法。类似java的静态方法
  def self.static_method
  end

  # 另一种定义静态方法的方式
  # https://github.com/Talkdesk/talkdesk_main/blob/qa/lib/talkdesk/validators/core_user_validator.rb
  class << self
    def static_method2
    end
  end

  def public_method
  end

  # 所有后面的实例方法都成为private方法
  private

  def private_method_a
  end
end

## private, protect 和 java 不同
# * 子类仍然可以覆盖private方法
# * 子类里可以直接调用父类的private方法


##### module
# module 是 class 的父类。除了不能实例化外，和类没区别
# 用于容纳类、方法和常量的定义

### 作为命名空间, 避免命名冲突
module A
  CONSTANT = "constant"

  class Foo
  end
end

module B
  CONSTANT = "constant"

  class Foo
  end
end

### include/extend
module Greeting
	def greet(name)
		puts "Hi, #{name}"
	end
end

class Human
  # 被 include的module里的方法，成为实例方法
  # include 也是个方法
	include Greeting
end
Human.new.greet("sergio") # => Hi, sergio

class Human2
  # 被 extend 的 module里的方法，成为类方法
  # extend 也是个方法
  extend Greeting
end
Human2.greet("sergio") # => Hi, sergio

class Human3
end
human = Human3.new
# 给实例扩展方法
human.extend(Greeting)
human.greet("sergio") # => Hi, sergio

## 存放静态工具方法
module Utils
  def self.method_a
  end
end

Utils.method_a

##### require
### require 一个文件
# * 相当于执行了对应的文件
# * require过的文件，再次require不会重复执行

# 绝对路径, 可以省略文件后缀
require '/Users/mxx/Desktop/ruby-session/file1.rb'
# 相对路径
require './file2'
# 在LOAD_PATH下查找文件
$LOAD_PATH.push(".")
require 'file3'

### require 一个gem
require 'nokogiri'
puts $LOAD_PATH

## 实际做了什么?
# * 在gems安装目录查找，哪个gem文件夹下 lib 目录有同名的文件
# * 找到gem后，把gem的lib目录添加到 $LOAD_PATH 里
# * 执行对应的文件
