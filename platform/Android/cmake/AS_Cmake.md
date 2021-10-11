## AS_Cmake

### 环境配置

#### 指定Cmake 与 NDK

1. 下载工具
   1. CMake
   2. LLDB
   3. NDK

2. 配置特定版本的CMake

   ```groovy
   android {
       ...
       externalNativeBuild {
           cmake {
               ...
               version "cmake-version"
           }
       }
   }
   ```

   将 CMake 的安装路径添加到 `PATH` 环境变量，或将其添加到项目的 `local.properties` 文件中

   ```groovy
   cmake.dir="path-to-cmake"
   ```

   

3. 配置特定版本的NDK

   ```groovy
   android {
       ndkVersion "major.minor.build" // e.g.,  ndkVersion '21.3.6528147'
   }
   ```

   

4. 

##### 最简单引入Cmake

###### Module：build.gradle

```groovy
android {
    defaultConfig {
        ...
        externalNativeBuild {
            cmake {
                abiFilters 'armeabi','armeabi-v7a', 'arm64-v8a'
            }
        }
    }
 
    externalNativeBuild {
        cmake {
            path "src/main/cpp/CMakeLists.txt"
        }
    }
}
```

###### CMakeLists.txt

```cmake
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

#显示执行构建过程中详细的信息(比如为了得到更详细的出错信息)
SET(CMAKE_VERBOSE_MAKEFILE on)

add_definitions(-DANDROID)

include_directories(
		#头文件包含的路径
        jni
)

find_library(
        log-lib
        #需查找的库文件
        log
        )

add_library(
		#生成库的名称
        native-lib
        #指定为共享库
        SHARED
        #源文件
        native-lib.c)		//特别注意，此文件后缀为 .c

target_link_libraries(
		#生成库名称
        native-lib
        #引用库集
        ${log-lib}
        )
```

###### native-lib.c



##### 指定libs路径

###### build.gradle

```groovy
android {
    ...
	sourceSets {
        main {
            jniLibs.srcDirs = ['libs']			//指定第三方库的路径，不指定会导致运行时找不到第三方库文件
        }
    }
    ...
    ndk {
		abiFilters 'armeabi','armeabi-v7a', 'arm64-v8a'		//打包指定平台的so到apk 中
    }
}
```



###### CMakeLists.txt

```cmake
LINK_DIRECTORIES(${my_lib_path}/${ANDROID_ABI}/)

# 或者如下方式引入

#将第三方库作为动态库引用
add_library(xxx
        SHARED
        IMPORTED)

#指定第三方库的绝对路径
set_target_properties(xxx
        PROPERTIES IMPORTED_LOCATION
        ${my_lib_path}/${ANDROID_ABI}/libxxx.so)
```

##### 注意

###### .c 文件

```c
(*env)->GetStringUTFChars(env,input_jstr, NULL);
```

###### .cpp后缀

引用 c 函数，需要添加  extern "C"，避免重载的原因导致找不到函数引用

```c++
extern "C"{}
env->GetStringUTFChars(input_jstr, NULL);
```

