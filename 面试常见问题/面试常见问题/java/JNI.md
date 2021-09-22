## JNI

名词解释：

为什么要用JNI：在C/C++中写的程序可以避开JVM的内存开销过大的限制、处理高性能的计算、调用系统服务(例如驱动)等功能。

**JVM**: jvm是java虚拟机在jni层的代表，全局只有一个。

**JNIENV**: 代表了java在本线程的运行环境，每个线程都有一个。

**JOBJECT**: 在JNI中除了基本类型数组、Class、String和Throwable外其余所有Java对象的数据类型在JNI中都用jobject表示

```c
extern JavaVM *jni_jvm;
static bool attach_jvm(JNIEnv **jni_env)
{
    if ((*jni_jvm)->GetEnv(pj_jni_jvm, (void **)jni_env,
                               JNI_VERSION_1_4) < 0)
    {
        if ((*jni_jvm)->AttachCurrentThread(jni_jvm, jni_env, NULL) < 0)
        {
            jni_env = NULL;
            return PJ_FALSE;
        }
        return PJ_TRUE;
    }

    return PJ_FALSE;
}

```



### JNI工作原理

![](./png/JNI工作原理.png)

### JNI层缓存

##### JNI缓存ID

C++调用java需要查找类，查找方法，查找方法ID，获取字段或者方法的调用有时候会需要在JVM中完成大量工作，因为字段和方法可能是从超类中继承而来的，为特定类返回的id不会在Jvm进程生存期间发生变化 ，这会让jvm**向上遍历类层次结构**来找到它们，这是个**开销很大**的操作。

所以，缓存ID字段是为了降低CPU负载，提高运行速度，节约电量。

#### 缓存类型

##### Global Reference

全局引用生存周期为创建后，直到程序员显示的释放它，否则一直存在

全局引用可以在多线程之间共享其指向的对象。

```c
jobject localRef =xxx;
jobject globalRef = env->NewGlobalRef(localRef);
env->DeleteLocalRef(localRef);
```



##### Local Reference

局部引用生存周期为创建后，直到DeleteLocalRef . 或在该方法结束后没有被JVM发现有JAVA层引用而被JVM回收并释放。

局部引用只对当前线程有效，多个线程间不能共享局部引用。

局部引用在JVM中是有个数限制的，默认16个，注意管理释放。

##### Weak Global Reference

弱全局引用生命周期为创建之后，直到DeleteGlobalRef。或在内存紧张时进行回收而被释放。

##### 缓存方法推荐

jobject默认是local Ref，函数环境消失时会跟随消失

在jni_onload初始化全局引用和弱全局引用

jmethodID/jfielID和jobject没有继承关系，他不是个object,只是个整数，不存在被释放与否的问题，可用全局变量保存。

jclass是由jobject继承而来的类，所以它是个jobject，需要用弱全局引用来缓存jclass对象。 

局部引用管理new出来的对象，注意及时delete。

### 数据传递

#### 值传递

GetByteArrayRegion

SetByteArrayRegion	//jni 传递数组到Java层

#### 址传递

##### GetByteArrayElements

​	将本地的数组指针直接指向Java端的数组地址，其实**本质**上是JVM在堆上分配的这个数组对象上增加一个引用计数，保证垃圾回收的时候不要释放，从而交给本地的指针使用，使用完毕后指针一定要记得通过**ReleaseByteArrayElements**进行释放，否则会产生内存泄露。

##### GetDirectBufferAddress

通过Direct Buffer来传递，这种方式类似于在堆上创建创建了一个Java和Jni层**共享**的整块**内存**区域，无论是Java层或者Jni层均可访问这块内存，并且Java端与Jni端同步变化，由于是采用的是共享内存的方式，因此相比于普通的数组传递，效率更高，但是由于构造/析构/维护这块共享内存的代价比较大，所以小数据量的数组建议还是采用上述方式，Direct Buffer方式更适合长期使用频繁访问的大块内存的共享。

有了 ByteBuffer, JNI 端就可以通过 GetDirectBufferAddress 获得内存地址

只能使用NewDirectByteBuffer 或者 ByteBuffer.allocateDirect() 进行创建,否则 GetDirectBufferAddress 返回的总是 NULL 。

##### GetPrimitiveArrayCritical

1. GetPrimitiveArrayCritical 得到底层数据指针
2. JNI 端调用 Java 代码, 很可能产生 GC
3. 底层数据指针所属的 Java 对象被 GC 了, 这个指针自然也就无效了

