# Java 存储结构

在android系统中，Enum枚举类型消耗的内存是静态常量的2倍



### SparseArray

   android中在键值对存储上的优化主要做了一下几种类型的优化:
        int --> Object(SparseArray)
        int --> int(SparseIntArray)
        int --> boolean(SparseBooleanArray)
        int --> long(SparseLongArray)
        int --> Set(SparseSetArray)
    特点：
        以键值对形式进行存储，基于键值的二分查找,因此查找的时间复杂度为0(LogN);
        由于SparseArray中Key存储的是数组形式,且升序排列，因此可以直接以int作为Key。避免了HashMap的装箱拆箱操作,性能更高且int的存储开销远远小于Integer;
        采用了延迟删除的机制(针对数组的删除扩容开销大的问题的优化) 



#### Pair：返回键值对

```java
Pair<String,String> pair=new Pair<>("aku", "female");
pair.getKey();
pair.getValue();
pair.getLeft();
pair.getRight();
```