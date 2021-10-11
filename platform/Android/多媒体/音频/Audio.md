# Android Audio



#### Audio 延时问题

音频延迟比较大，平均要 150ms。后来Android添加了 FastMixer 和 AUDIO_OUT_PUT_FLAG_FAST 等，来解决这个问题。

判断设备是否支持 FastPath，需要用到这两个特性：
		android.hardware.audio.low_latency  		 指示 45 毫秒或更短的持续输出延迟时间。
		android.hardware.audio.pro          				指示 20 毫秒或更短的持续往返延迟时间。

##### 常见类型的延迟时间

音频输出时间延迟            音频样本由应用生成到通过耳机插孔或内置扬声器播放之间的时间。
音频输入延迟时间            音频信号由设备音频输入（如麦克风）接收到相同音频数据可被应用使用的时间。
往返延迟时间                	输入延迟时间、应用处理时间和输出延迟时间的总和。
触摸延迟时间                	用户触摸屏幕与触摸事件被应用接收之间的时间。
预热延迟时间                	启动音频管道、数据第一次在缓冲区加入队列所需的时间。

##### 最大程度减少延迟时间的做法

验证音频性能
		了解设备是否能为延迟时间提供任何保证：
				android.hardware.audio.low_latency 		 指示 45 毫秒或更短的持续输出延迟时间
				android.hardware.audio.pro 						指示 20 毫秒或更短的持续往返延迟时间

android.hardware.audio.low_latency 功能是 android.hardware.audio.pro 的先决条件。

```java
boolean hasLowLatencyFeature = getPackageManager().hasSystemFeature(
    PackageManager.FEATURE_AUDIO_LOW_LATENCY);
boolean hasProFeature = getPackageManager().hasSystemFeature(PackageManager.FEATURE_AUDIO_PRO);
```

##### 最大程度的减少输入延迟时间

1. 移除任何不需要的信号处理
2. 准备好处理由 PROPERTY_OUTPUT_SAMPLE_RATE 的 getProperty(String) 报告的名义采样率，常见 44100 和 48000
3. 准备好处理由 PROPERTY_OUTPUT_FRAMES_PER_BUFFER 的 getProperty(String) 报告的缓冲区大小。常见有 96、128、160、192、240、256 或 512 帧

##### 最大程度减少输出延迟时间

###### 使用最佳采样率创建音频播放器

从 AudioManager 获得最佳采样率

```java
AudioManager am = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
String sampleRateStr = am.getProperty(AudioManager.PROPERTY_OUTPUT_SAMPLE_RATE);
int sampleRate = Integer.parseInt(sampleRateStr);
if (sampleRate == 0) sampleRate = 44100; // Use a default value if property not found
```

###### 使用最佳缓冲区大小

获得最佳缓冲区大小：

```java
AudioManager am = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
String framesPerBuffer = am.getProperty(AudioManager.PROPERTY_OUTPUT_FRAMES_PER_BUFFER);
int framesPerBufferInt = Integer.parseInt(framesPerBuffer);
if (framesPerBufferInt == 0) framesPerBufferInt = 256; // Use default   
```



> PROPERTY_OUTPUT_FRAMES_PER_BUFFER 属性表示 HAL（硬件抽象层）缓冲区可以容纳的音频帧数量。 您应构建音频缓冲区，使其可以容纳这个数量的确切倍数。 如果使用准确数量的音频帧，会定期出现回调，这将减少抖动。

###### 避免添加涉及信号处理的输出接口

> 快速混合器仅支持下列这些接口：
> 		SL_IID_ANDROIDSIMPLEBUFFERQUEUE
> 		SL_IID_VOLUME
> 		SL_IID_MUTESOLO
> 不支持以下这些接口，因为它们涉及信号处理，且会导致快速音轨的请求被拒绝：
> 		SL_IID_BASSBOOST
> 		SL_IID_EFFECTSEND
> 		SL_IID_ENVIRONMENTALREVERB
> 		SL_IID_EQUALIZER
> 		SL_IID_PLAYBACKRATE
> 		SL_IID_PRESETREVERB
> 		SL_IID_VIRTUALIZER
> 		SL_IID_ANDROIDEFFECT
> 		SL_IID_ANDROIDEFFECTSEND

```java
const SLInterfaceID interface_ids[2] = { SL_IID_ANDROIDSIMPLEBUFFERQUEUE, SL_IID_VOLUME };
```

> 

#####  最大程度减少预热延迟时间

第一次将音频数据加入队列时，设备音频电路需要较短、但仍十分重要的一段时间来预热。 要避免这种预热延迟时间，您可以将包含无声的音频数据缓冲区加入队列


```c++
#define CHANNELS 1
static short* silenceBuffer;
int numSamples = frames * CHANNELS;
silenceBuffer = malloc(sizeof(*silenceBuffer) * numSamples);
for (i = 0; i < numSamples; i++) {
	silenceBuffer[i] = 0;
}
```
需要生成音频时，您可以将包含真实音频数据的缓冲区加入队列。

持续输出音频将消耗大量的电量。请确保您在 onPause() 方法中停止输出。另外，请考虑在用户无活动的一段时间后暂停无声输出。

##### 验证您正在使用低延迟时间音轨

> adb shell ps | grep your_app_name
> adb shell dumpsys media.audio_flinger
> 扫描您的进程 ID。如果您在 Name 列看到 F，表示它在低延迟时间音轨上（F 代表快速音轨）