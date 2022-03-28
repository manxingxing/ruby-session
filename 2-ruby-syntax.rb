
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
listB = [1, 2, "string", 23.23, *sublist]

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

### 常量
# 所有以大些字母开头的，都是常量!!(类也是常量)
# 定义后仍然可以修改，只是产生一个warning(一般不会乱改的啦...)

# * 普通常量
# * 类
# * module

A_CONSTANT = "a constant"

module SomeModule
  module InnerModule
    class MyClass
      CONSTANT = 4
    end
  end
end

SomeModule::InnerModule::MyClass::CONSTANT
# 互相嵌套的module/class 构成一个大的常量树。整个解释器环境就是一个大的常量树

### block, lambda


### 集合遍历


### control-flow


### 方法


### 类


### require
