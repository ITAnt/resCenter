# Android MediaCodec

### MediaCodec

手机设备配置文件：
	system/etc/
	vendor/etc/
		media_codecs.xml 等

#### 异步

MediaCodec采用异步方式处理数据，并且使用了一组输入输出缓存（input and output buffers）来存放待处理数据以及处理完的数据。开发者只需将待编解码的数据放入输入缓冲区交给编解码器，再从输出缓冲区获取编解码后的数据即可。

其工作方式大致如下：
	1、请求或接收一个空的输入缓存（input buffer）。
	2、向其中填充待处理的数据，并将它传递给编解码器处理。
            3、MediaCodec处理完这些数据并将处理结果输出至一个空的输出缓存（output buffer）中。
            4、请求或接收到一个填充了处理后数据的输出缓存（output buffer）。
            5、使用完其中的数据，并将其释放给编解码器再次使用。

#### 生命周期

MediaCodec主要的状态为：Stopped、Executing、Released。
		Stopped 的状态下也分为三种子状态：Uninitialized、Configured、Error。
		Executing 的状态下也分为三种子状态：Flushed、 Running、End-of-Stream。

1. 当创建编解码器的时候处于未初始化状态。首先需要调用configure(…)方法进入
   **Configured** 状态，然后调用 start() 方法让其处于 **Executing** 状态。在Executing状态下，就可以缓冲区来处理数据。
2. Executing的状态下也分为三种子状态：Flushed、 Running、End-of-Stream。在start() 调用后，编解码器处于 **Flushed** 状态，这个状态下它保存着所有的缓冲区。一旦第一个输入 buffer 出现了，编解码器就会自动运行到 **Running** 的状态。当带有end-of-stream标志的 buffer 进去后，编解码器会进入 **End-of-Stream** 状态，这种状态下编解码器不在接受输入buffer，但是仍然在产生输出的buffer。此时可以调用 flush() 方法，将编解码器重置于 **Flushed** 状态。
3. 调用stop()可以将编解码器返回到 **Uninitialized** 状态，然后可以重新配置。
4. 在底层编解码出错的情况下，MediaCodec**会转到错误状态**。调用 reset() 使编解码器再次可用，reset() 可以从任何状态将编解码器移 **Uninitialized** 状态。
5. 当MediaCodec数据处理任务完成时或不再需要MediaCodec时，可使用 release() 方法释放其资源，到达 **Released** 状态。

##### 总结

创建                ---> 	未初始化状态
configure()    ---> 	Configured
start()             --->	 Executing--Flushed
	第一个输入buffer 出现，	Running
	end-of-stream标志的buffer输入，	End-of-Stream (不可输入，可输出) ，调用flush() 可切换到 Flused 状态
 stop()            ---> 	Uninitialized 状态，可重新配置
 出错               ---> 	Error状态，调用 reset() 再次可用（回到 Uninitialized 状态）
 release()       --->	 Release 状态




​            
​            