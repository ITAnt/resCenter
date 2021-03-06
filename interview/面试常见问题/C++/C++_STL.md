## C++ STL

#### string

​			assign
​			append
​			find/replace
​			compare
​			at []
​			insert / erase
​			substr

#### vector

​			动态扩展
​			栈
​			指针
​				begin
​				end
​				rbegin
​				rend
​			操作
​				vector(v.begin(),v.end())
​				assign() = 
​				empty() capacity() size() resize()
​				push_back()	pop_back() insert() erase()
​				front() [] back() at()
​				swap()
​				reverse()

#### dequeue（双向队列）

​		内部工作原理(中控器)
​		优点
​			对头部的插入和删除速度比 vector 快	
​		支持随机访问
​		指针
​			front()
​			back()
​			begin()
​			end()
​		操作
​			push_front()	pop_front() push_back() push_front()
​			assign() =
​			empty() capacity() size() resize()
​			insert() erase() clear()
​			at() []	front()	back()
​			sort()

#### stack

​		不允许有遍历操作，只有一个出口
​		操作
​			=
​			push()	pop()	top()
​			empty()	size()

#### queue

​		不允许有遍历行为，只有队头和队尾才能被外界访问
​		操作
​			push()	back()	front()	pop()
​			=
​			empty()	size()

#### list

​		不支持随机访问
​		链式存储，双向循环链表，双向迭代器
​		特性：
​			插入删除操作都不会导致原有 list 迭代器失效，这在vector 是不成立的
​		操作
​			front() back()	//存取
​			assign()	=		swap()
​			size() empty()	resize()
​			push_back()	pop_back()	push_front()	push_back()	insert()
​			reverse()
​			sort()	//自定义类型，需要定义排序规则

#### set

​		关联式容器
​		插入时自动被排序,如需改变可利用仿函数改变排序规则
​		二叉树实现
​		set 与 multiset区别
​			set：不允许有重复元素
​			multiset：允许有重复元素
​		操作
​			=
​			size()	empty()
​			swap()
​			insert()--返回pair对组	erase()	clear()
​			find()	count(key)
​		pair对组
​			成对出现的数据
​			pair<type,type> p = make_pair(value1,value2);

#### map	

​		所有元素都是 pair
​		根据健值自动排序,利用仿函数可以改变排序规则
​		关联式容器，二叉树实现
​		map 与 multimap 的区别：
​			map 不允许有重复 key 元素
​			multimap 允许有重复 key元素
​		操作
​			=
​			insert()	erase()
​			size()	empty()	
​			swap()
​			[]
​			find()	count()

### 迭代器失效

​	对于序列式容器，例如vector、deque；由于序列式容器是组合式容器，当当前元素的iterator被删除后，其后的所有元素的迭代器都会失效，这是因为vector，deque都是连续存储的一段空间，所以当对其进行erase操作时，其后的每一个元素都会向前移一个位置。
​	已经失效的迭代器不能进行++操作。不过vector的erase操作可以返回下一个有效的迭代器，所以只要我们每次执行删除操作的时候，将下一个有效迭代器返回就可以顺利执行后续操作了。
​	it = vec.erase(it);	//更新迭代器it 后就可以操作了，这个迭代器是vector内存调整过后新的有效的迭代器。此时就可以进行正确的删除与访问操作了。

#### vector迭代器失效问题总结

（1）当执行erase方法时，指向删除节点的迭代器全部失效，指向删除节点之后的全部迭代器也失效
（2）当进行push_back（）方法时，end操作返回的迭代器肯定失效。
（3）当插入(push_back)一个元素后，capacity返回值与没有插入元素之前相比有改变，则需要重新加载整个容器，此时first和end操作返回的迭代器都会失效。
（4）当插入(push_back)一个元素后，如果空间未重新分配，指向插入位置之前的元素的迭代器仍然有效，但指向插入位置之后元素的迭代器全部失效。

#### deque迭代器失效总结：

（1）对于deque,插入到除首尾位置之外的任何位置都会导致迭代器、指针和引用都会失效，但是如果在首尾位置添加元素，迭代器会失效，但是指针和引用不会失效
（2）如果在首尾之外的任何位置删除元素，那么指向被删除元素外其他元素的迭代器全部失效
（3）在其首部或尾部删除元素则只会使指向被删除元素的迭代器失效。

#### 关联容器

对于关联容器(如map, set,multimap,multiset)，删除当前的iterator，仅仅会使当前的iterator失效，只要在erase时，递增当前iterator即可。这是因为map之类的容器，使用了红黑树来实现，插入、删除一个结点不会对其他结点造成影响。erase迭代器只是被删元素的迭代器失效，但是返回值为void，所以要采用erase(iter++) 的方式删除迭代器。
主要解释一下erase(it++)的执行过程：

​	这句话分三步走，先把iter传值到erase里面，然后iter自增，然后执行erase,所以iter在失效前已经自增了。
map是关联容器，以红黑树或者平衡二叉树组织数据，虽然删除了一个元素，整棵树也会调整，以符合红黑树或者二叉树的规范，但是单个节点在内存中的**地址没有变化**，**变化的是**各节点之间的**指向关系**。



### 函数对象

​	本质：
​		函数对象(仿函数)是一个类，不是一个函数
​	可以有参数，可以有返回值
​	调用
​		MyAdd myAdd;
​		数据类型 返回值 = myAdd(形参);
​	谓词
​		返回bool 类型的仿函数称为谓词
​	内建函数对象
		#include <functional>
​		算术仿函数
​		关系仿函数
​		逻辑仿函数


​	
​	
​	