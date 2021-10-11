## Java 8 特性

### Stream

#### parallelStream

原理：分而治之，子任务执行完毕后，再把结果合并
        特点：
            并发、无序、非线程安全
        缺点：
            如果cpu资源紧张parallelStream不会带来性能提升；如果存在频繁的线程切换反而会降低性能

```java
List<Person> persons;
persons.stream().forEach(x -> {
	try {	
        Thread.sleep(1000);
    } catch (InterruptedException e) {
        
    }
    System.out.println(x.name);
});

persons.parallelStream().forEach(x -> {   //并发
    try {
        Thread.sleep(1000);
    } catch (InterruptedException e) {
        
    }
    System.out.println(x.name);
});

IntStream.range(0, 1000).forEach(listFor::add);
//不能保证正确性
IntStream.range(0, 1000).parallel().forEach(listParallel::add);
```
### default

接口内部包含了一些默认的方法实现,从而使得接口在进行扩展的时候，不会破坏与接口相关的实现类代码。

引进默认方法的目的是为了解决接口的修改与现有的实现不兼容的问题。

实现两个接口(定义了相同的默认方法)，此时编译器会报错，解决办法是在实现类中重新实现该方法。

继承一个类并且实现一个接口，都实现了相同的默认方法，则执行的是类中方法(类优先于接口)

### Supplier

函数式接口

```java
//创建了Supplier的实现对象，声明为Supplier<类型>，此时并不会调用对象的构造方法，即不会创建对象
Supplier<Test> suTest = Supplier::new;
//调用get()方法，此时会调用对象的构造方法，即获得到真正对象

suTest.get();
```



```java
//结合 lambda 使用
System.out.println(getString(() -> msgA + msgB));

private static String getString(Supplier<String> stringSupplier) {
	return stringSupplier.get();
}
```
### Lambda

Lambda 允许把函数作为一个方法的参数（函数作为参数传递进方法中）

语法格式：

​	(parameters) -> expression

或

​	(parameters) ->{ statements; }

lambda表达式的重要特征:
		可选类型声明：      	不需要声明参数类型，编译器可以统一识别参数值。
		可选的参数圆括号：  一个参数无需定义圆括号，但多个参数需要定义圆括号。
		可选的大括号：      	如果主体包含了一个语句，就不需要使用大括号。
		可选的返回关键字：  如果主体只有一个表达式返回值则编译器会自动返回值，大括号需要指定表达式返回了一个数值。

示例：

```java
//不要参数，返回值 5
() -> 5  
```

使用 Lambda 表达式需要注意以下两点：

1. Lambda 表达式主要用来定义行内执行的方法类型接口，例如，一个简单方法接口
2. Lambda 表达式免去了使用匿名方法的麻烦，并且给予Java简单但是强大的函数化的编程能力。

接口：

```java
interface MathOperation {
	int operation(int a, int b);
}
```

```java
// 类型声明
MathOperation addition = (int a, int b) -> a + b;

// 不用类型声明
MathOperation subtraction = (a, b) -> a - b;
    
// 大括号中的返回语句
MathOperation multiplication = (int a, int b) -> { return a * b; };
    
// 没有大括号及返回语句
MathOperation division = (int a, int b) -> a / b;
```

变量作用域：
		lambda 表达式只能引用标记了 final 的外层局部变量，这就是说不能在 lambda 内部修改定义在域外的局部变量，否则会编译错误。
        lambda 表达式的局部变量可以不用声明为 final，但是必须不可被后面的代码修改（即隐性的具有 final 的语义）            

```java
//未声明为 final，默认为 final
int num = 1;  
Converter<Integer, String> s = (param) ->
		System.out.println(String.valueOf(param + num));
s.convert(2);
num = 5;        //修改，编译报错
```
在 Lambda 表达式当中不允许声明一个与局部变量同名的参数或者局部变量。

```java
String first = "";  
Comparator<String> comparator = (first, second) ->
		Integer.compare(first.length(), second.length());  //编译会出错 
```
