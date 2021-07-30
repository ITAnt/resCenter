### H.264语义字段

#### NAL 层语义

forbidden_zero_bit：  等于0

nal_ref_idc： 指示当前NAL的优先级。取值范围为0～3，值越高，表示当前NAL越重要，越需要优先受到保护。H.264规定如果当前NAL是一个序列参数集(SPS)，或一个图像参数集（PPS），或属于参考图像的片或片分区等重要的数据单位时，本句法元素必须大于0。但在大于0时具体该取何值，并没有进一步的规定。当nal_unit_type 等于 5 时，nal_ref_idc 大于 0; nal_unit_type 等于6、9、10、11 或12时，nal_ref_idc等于 0。

nal_unit_type：

| nal_unit_type |        NAL 类型        |    C    |
| :-----------: | :--------------------: | :-----: |
|       0       |         未使用         |         |
|       1       | 不分区、非IDR图像的片  | 2，3，4 |
|       2       |        片分区A         |    2    |
|       3       |        片分区B         |    3    |
|       4       |        片分区C         |    4    |
|       5       |     IDR图像中的片      |  2，3   |
|       6       | 补充增强信息单元( SEI) |    5    |
|       7       |       序列参数集       |    0    |
|       8       |       图像参数集       |    1    |
|       9       |         分界符         |    6    |
|      10       |        序列结束        |    7    |
|      11       |        码流结束        |    8    |
|      12       |          填充          |    9    |
|    13～23     |          保留          |         |
|    24～31     |         未使用         |         |

nal_unit_type = 5时，表示当前NAL是IDR图像的一个片。

rbsp_byte[i]：RBSP的第i个字节。RBSP指原始字节载荷，它是NAL单元的数据部分的封装格式，封装的数据来自SODB (原始数据比特流）。SODB是编码后的原始数据，SODB经封装为RBSP后放入NAL的数据部分。下面介绍一个RBSP的生成顺序。从SODB到RBSP的生成过程如下所述：

1. 如果SODB内容是空的，生成的RBSP也是空的
2. 否则， RBSP由如下的方式生成：
   1. RBSP的第一个字节直接取自SODB的第1～8个比特(RBSP字节内的比特按照从左到右对应为从高到低的顺序排列)，以此类推，RBSP其余的每个字节都直接取自 SODB 的相应比特；
   2. RBSP 的最后一个字节包含 SODB 的最后几个比特，及如下的 rbsp_trailing_bits()，rbsp_trailing_bits() 的第一个比特是1，接下来填充 0，直到字节对齐（填充0 的目的也是为了字节对齐）
   3. 最后添加若干个 cabac_zero_word (其值等于 0x0000)

emulation_prevention_three_byte： NAL内部为防止与起始码竞争而引入的填充字节，值为 0x03。

#### 序列参数集语义

profile_idc、 level_idc：指明所用profile、level

constraint_set0_flag 等于1时表示必须遵从指明的所有制约条件，等于0时表示不必遵从所有条件

constraint_set1_flag 等于1时表示必须遵从指明的所有制约条件，等于0时表示不必遵从所有条件。

​	注意：当constraint_set0_flag、constraint_set1_flag、constraint_set2_flag中有两个以上等于 1 时，本章参考文献[1]中附录A.2中的所有制约条件都要被遵从。

reserved_zero_5bits 在目前的标准中本句法元素必须等于0，其他的值保留做将来用，解码器应该忽略本句法元素的值。

seq_parameter_set_id： 指明本序列参数集的id号，这个id号将被picture参数集引用，本句法元素的值应该在[0，31]。

​	注意：当编码器需要产生新的序列参数集时，应该使用新的seq_parameter_set_id，即使用新的序列参数集，而不是去改变原来的参数集中的内容。

log2_max_frame_num_minus4：这个句法元素主要是为读取另一个句法元素frame_num 服务的，frame_num是最重要的句法元素之一，它标识所属图像的解码顺序。可以在句法表看到， frame_num 的解码函数是ue (v)，函数中的 v 在这里指定：

​	v=  log2_max_frame_num_minus4 + 4

​	从另一个角度看，这个句法元素同时也指明了frame_num的所能达到的最大值：

​	MaxFrameNum = 2^(log2_max_frame_num_minus4 +4)

​	变量MaxFramNum表示frame_num 的最大值，在解码过程中，它也是一个非常重要的变量。值得注意的是frame_num是循环计数的，即当它到达MaxFrameNum后又从0重新开始新一轮的计数。解码器必须要有机制检测这种循环，不然会引起类似千年虫的问题，在图像的顺序上造成混乱。

pic_order_cnt_type： 指明了POC (Picture Order Count) 的编码方法、POC标识图像的播放顺序。由于H.264使用了B帧预测，使得图像的解码顺序并不一定等于播放顺序，但它们之间存在一定的映射关系。 POC 可以由frame-num通过映射关系计算得来，也可以索性由编码器显式地传送。 H.264中一共定义了3种POC的编码方法，这个句法元素就是用来通知解码器该用哪种方法来计算POC。 pic_order_cnt-type的取值范围是 [0，2]。在如下的视频序列中本句法元素不应该等于2：

1. 一个非参考帧的接入单元后面紧跟着一个非参考图像（指参考帧或参考场)的接入单元
2. 两个分别包含互补非参考场对的接入单元后面紧跟着一个非参考图像的接入单元
3. 一个非参考场的接入单元后面紧跟着另外一个非参考场，并且这两个场不能构成一个互补场对。

log2_max_pic_order_cnt_lsb_minus4：指明了变量MaxPicOrderCntLsb的值：

​	MaxPicOrderCntLsb = 2^(log2_max_pic_order_cnt_lsb_minus4+4)

​	该变量在 pic_order_cnt_type = 0时使用。

delta_pic_order_always_zero_flag：等于1 时，句法元素 delta_pic_order_cnt[0] 和 delta_pic_order_cnt[1] 不在片头出现，并且它们的值默认为0；本句法元素等于0时，上述的两个句法元素将在片头出现。

offset_ for_non_ref_pic：被用来计算非参考帧或场的picture order count，本句法元素的值应该在[-2^31，2^31 - 1]范围内。

offset_for_top_to_bottom_field：被用来计算图像帧中的底场的picture order count，本句法元素的值应该在[-2^31，2^31 - 1]范围内。

num_ref_frames_in_pic_order_cnt_cycle：被用来解码picture order count，本句法元素的值应该在[0，255]范围内。

offset_for_ref_frame[i]：在picture order count type=1 时用，用于解码POC，本句法元素对循环 num_ref_frames_in_pic_order_cycle 中的每一个元素指定一个偏移。

num_ref_frames：指定参考帧队列可能达到的最大长度，解码器依照这个句法元素的值开辟存储区，这个存储区用于存放已解码的参考帧，H.264规定最多可用16个参考帧，本句法元素的值最大为16 。值得注意的是这个长度以帧为单位，如果在场模式下，应该相应地扩展一倍。

gaps_in_frame_num_value_allowed_flag：这个句法元素等于1 时，表示允许句法元素 frame_num 可以不连续。当传输信道堵塞严重时，编码器来不及将编码后的图像全部发出，这时允许丢弃若干帧图像。在正常情况下每一帧图像都有依次连续的frame_num值，解码器检查到如果frame_num不连续，便能确定有图像被编码器丢弃。这时，解码器必须启动错误掩藏的机制来近似地恢复这些图像，因为这些图像有可能被后续图像用作参考帧。

​	当这个句法元素等于0时，表不允许frame_num不连续，即编码器在任何情况下都不能丢弃图像。这时， H.264允许解码器可以不去检查frame_num的连续性以减少计算量。这种情况下如果依然发生frame_num不连续，表示在传输中发生丢包，解码器会通过其他机制检测到丢包的发生，然后启动错误掩藏的恢复图像。

pic_width_in_mbs_minus1：本句法元素加 1 后指明图像宽度，以宏块为单位：

​	PicWidthInMbs = pic_width_in_mbs_minus1 + 1

​	通过这个句法元素解码器可以计算得到亮度分量以像素为单位的图像宽度：

​	PicWidthInSamplesL=PicWidthInMbs x 16

​	从而也可以得到色度分量以像素为单位的图像宽度：

​	PicWidthInSamplesC = PicWidthInMbs x 8

​	以上变量PicWidthInSamplesL、PicWidthInSamplesC分别表示图像的亮度、色度分量以像素为单位的宽。

​	H.264将图像的大小在序列参数集中定义，意味着可以在通信过程中随着序列参数集动态地改变图像的大小。

pic_heigh t_in_map_units_minus1：本句法元素加1后指明图像高度：

​	PicHeightInMapUnits = pic_height_in_map_units_minus1 +1

​	PicSizeInMapUnits = PicWidthInMbs x PicHeightInMapUnits

​	图像的高度的计算要比宽度的计算复杂，因为一个图像可以是帧也可以是场，从这个句法元素可以在帧模式和场模式下分别计算出亮度、色度的高。值得注意的是，这里以 map_unit 为单位

frame_mbs_only_flag：本句法元素等于1时，表示本序列中所有图像的编码模式都是帧，没有其他编码模式存在；本句法元素等于0时，表示本序列中图像的编码模式可能是帧，也可能是场或帧场自适应，某个图像具体是哪一种要由其他句法元素决定。

​	结合map_unit的含义，这里给出上一个句法元素 pic_height_in_map_units minus1 的进一步解析步骤。

​	当frame_mbs_only_flag 等于1, pic_height_in_map_units_minus1 指的是一个 picture 中帧的高度：当frame_mbs_only_flag 等于0，pic_heght_in_map_units minus1 指的是一个picture中场的高度，所以可以得到如下以宏块为单位的图像高度：

​	FrameHeightlnMbs = ( 2 - frame_mbs only_fiag) x PicHeightInMapUnits

mb_adaptive_frame_field_flag：指明本序列是否属于帧场自适应模式。mb_adaptive_frame_field_flag等于 1 时，表明在本序列中的图像如果不是场模式就是帧场自适应模式；等于0时，表示本序列中的图像如果不是场模式就是帧模式。

​	全部是帧，对应于frame_mbs_only_flag =1的情况。

​	帧和场共存。frame_mbs_only_flag =0, mb_adaptive_frame_field_flag = 0 

​	帧场自适应和场共存。 frame_mbs_only_flag =0, mb_adaptivee_frame_field_flag =1

​	值得注意的是，帧和帧场自适应不能共存在一个序列中。

direct_8×8_inference_flag：用于指明 B 片的直接和 skip 模式下运动矢量的预测方法。

frarne_cropping_flag：用于指明解码器是否要将图像裁剪后输出，如果是的话，后面紧跟着的四个句法元素分别指出左、右、上、下裁剪的宽度。

frame_crop_left_offset，frame_crop_right_offset，frame_crop_bottom_offset，frame_crop_bottom_offset 如上一句法元素所述。

vui_parameters_present_flag：指明 vui 子结构是否出现在码流中，vui 的码流结构在本章参考文献[1]中的附录指明，用以表征视频格式等额外信息。

#### 图像参数集语义

pic_parameter_set_id：用以指定本参数集的序号，该序号在各片的片头被引用。

seq_parameter_set_id：指明本图像渗数集所引用的序列参数集的序号。

entropy_coding_mode_flag：指明熵编码的选择。本句法元素为0时，表示熵编码使用CAVLC： 本句法元素为1时，表示熵编码使用CABAC。

pic_order_present_flag：POC的3种计算方法在片层还各需要用一些句法元素作为参数。本句法元素等于1时，表示在片头会有句法元素指明这些参数；本句法元素等于0时，表示片头不会给出这些参数，这些参数使用默认值

num_slice_groups_minus1：本句法元素加 1 后指明图像中片组的个数。H.264中没有专门的句法元素用于指明是否使用片组模式，当本句法元素等于0时（即只有一个片组），表示不使用片组模式，后面也不会跟有用于计算片组映射的句法元素。

slice_group_map_type：规定了片组的映射类型，取值范围为[0，6] 。

​	map_units的定义如下：

1. 当如frame_mbs_only_flag 等于 1 时，map_units 指的就是宏块

2. 当frame_mbs_only_falg等于0时，又有以下几种情况：

   1. 帧场自适应模式时，map_units指的是宏块对

   2. 场模式时，map_units 指的是宏块

   3. 帧模式时，map_units 指的是与帧场自适应帧中的宏块对类似，垂直相邻的两个连续宏块的组合体。

run_length_minusl[i]：用以指明当片组类型等于0时，每个片组连续的 map_units 个数

top_left[i]，bottom_right[i]：用以指明当片组类型等于 2 时，矩形区域的左上及右下位置。

slice_group_change_direction_flag ：当片组类型等于3、4、5时，本句法元素与下一个句法元素一起指明确切的片组映射类型。

slice_group_change_rate_minus1：用以指明变量SliceGroupChangeRate。本句法元素表示一个片组的大小从一个图像到下一个的改变的倍数，以 map_units 为单位。
pic_size_in_map_units_minus1：在片组类型等于6时，用以指明图像以map_units为单位的大小

slice_group_id[i]：  在片组类型等于6 时，用以指明某个 map_units 属于哪个片组。

num_ref_idx_l0_active_ minus1：加1后指明目前参考帧队列的长度，即有多少个参考帧(包括短期和长期)。值得注意的是，当目前解码图像是场模式下，参考帧队列的长度应该是本句法元素再乘以2，因为场模式下各帧必须被分解以场对形式存在(这里所说的场模式包括图像的场及帧场自适应下的处于场模式的宏块对）。本句法元素的值有可能在片头被重载。

​	读者可能还记得在序列参数集中有句法元素 num_ref_frames 也是跟参考帧队列有关，它们的区别是：num_ref_frames 指明参考帧队列的最大值，解码器用它的值来分配内存空间；num_ref_idx_l0_ active_minus1 指明在这个队列中当前实际的、已存在的参考帧的数目，这从它的名字“active”中也可以看出来。

​	这个句法元素是 H.264 中最重要的句法元素之一，在第7章我们可以看到，编码器要通知解码器某个运动矢量所指向的是哪个参考图像时，并不是直接传送该图像的编号，而是传送该图像在参考帧队列中的序号。这个序号并不是在码流中传送的，而是编码器和解码器同步地、用相同的方法将参考图像放入队列，从而获得一个序号。这个队列在每解一个图像时，甚至是每个片后都会动态地更新。维护参考帧队列是编解码器十分重要的工作，而本句法元素是维护参考帧队列的重要依据。参考帧队列的复杂的维护机制也正是H.264重要且很有特色的组成部分。

num_ref_idx_ l1_active_minus1：与上一个句法元素的语义一致，只是本句法元素用于 list1， 而上一句法元素用于list0。

weighted_pred_flag：用以指明是否允许P和SP片的加权预测，如果允许，在片头会出现用以计算加权预测的句法元素。

weighted_bipred_idc：用以指明是否允许B片的加权预测。本句法元素等于0时表示使用默认加权预测模式，等于1时表示使用显式加权预测模式，等于2时表示使用隐式加权预测模式。

pic_init-qp_minus26：取值范围为[-26，+25]，加26后用以指明亮度分量的量化参数的初始值。在H.264中，量化参数分3个级别给出：图像参数集、片头、宏块。在图像参数集给出的是一个初始值。

pic_init_qs_minus26： 与上一个句法元素语义一致，只是用于SP和SI。

chroma_qp_index_offset：色度分量的量化参数是根据亮度分量的量化參数计算出来的，本句法元素用以指明计算时用到的参数。

deblocking_filter_control_present_flag：编码器可以通过句法元素显式地控制去块滤波的强度，本句法元素指明是在片头是否会有句法元素传递这个控制信息。如果本句法元素等于0，那些用于传递滤波强度的句法元素不会出现，解码器将独立地计算出滤波强度。

constrained_intra_pred_flag：在P和B片中，帧内编码的宏块的邻近宏块可能是采用的帧间编码。当本句法元素等于1时，表示帧内编码的宏块不能用帧间编码的宏块的像素作为自己的预测，即帧内编码的宏块只能用邻近帧内编码的宏块的像素作为自己的预测：而本句法元素等于0时，表示不存在这种限制

redundant_pic_cnt_present_flag：指明是否会出现 redudant_pic_cnt 句法元素

#### 片头语义

first_mb_in_slice：片中的第一个宏块的地址，片通过这个句法元素来标定它自己的地址。要注意的是，在帧场自适应模式下，宏块都是成对出现的，这时本句法元素表示的是第几个宏块对，对应的第一个宏块的真实地址应该是 2 x first_mb_in_slice。

slice_type：指明片的类型

| slice_type | Name of slice_type | slice_type | Name of slice_type |
| :--------: | :----------------: | :--------: | :----------------: |
|     0      |         P          |     5      |         P          |
|     1      |         B          |     6      |         B          |
|     2      |         I          |     7      |         I          |
|     3      |         SP         |     8      |         SP         |
|     4      |         SI         |     9      |         SI         |

IDR图像时，slice_type等于2、4、 7、9。

pic_parameter_set_id：图像参数集的索引号，取值范围为[0，255]

frame_num：每个参考帧都有一个依次连续的 frame_num 作为它们的标识，这指明了各图像的解码顺序。frane num 所能达到了最大值由前文序列参数集中的句法元素 log2_max_frame_num_minus4 推出。事实上我们在表中可以看到， frame_num 的出现没有 if 语句限定条件，这表明非参考帧的片头也会出现 frame_num。只是当该个图像是参考帧时，它所携带的这个句法元素在解码时才有意义。

| 图像序号 | 图像类型 | 是否作用参考 | frame_num |
| :------: | :------: | :----------: | :-------: |
|    1     |    I     |      是      |     0     |
|    2     |    P     |      是      |     1     |
|    3     |    B     |      否      |     2     |
|    4     |    P     |      是      |     2     |
|    5     |    B     |      否      |     3     |
|    6     |    P     |      是      |     3     |
|    7     |    B     |      否      |     4     |
|    8     |    P     |      是      |     4     |
|   ...    |   ...    |     ...      |    ...    |

​	注：该系列中B帧一律不作为参考帧，而P帧一律作为参考帧。

​	H.264 对frame_num 的值作了如下规定：当参数集中的句法元素gaps_in_frame_num_value allowed_flag 等于0时，每个图像的frame_num 值是其前一个参考帧的frame_num值加1。这句话包含有两层意思：

1. 当gaps_in_frae_num value_allowed_flag 等于0时，即frame_num连续的情况下，每个图像的frame_num由前一个参考帧图像对应的值加1，着重点是“前一个参考帧”。在上表中，第3个图像是B帧，按照定义，它的frame_num值应是前一个参考帧，即第2个图像对应的值加1，即为2；第4个图像是P帧，由于该序列B帧都不作为参考帧，所以对于该图像来说，定义中所谓的“前一个参考帧”，仍旧是指的第2个图像，所以对于第4个图像来说，它的frame_num的取值和第3个图像一样，也为2。相同的情况也发生在第6和第8帧上。

   前面我们曾经提到，对于非参考帧来说，它的frame_num 值在解码过程中是没有意义的，因为frame_num值是参考帧特有的，它的主要作用是在该图像被其他图像引用作运动补偿的参考时提供一个标识。但H.264并没有在非参考帧图像中取消这一句法元素，原因是在POC的第二种和第三种解码方法中可以通过非参考帧的frame_num值计算出它们的POC值。

2. 当gaps_in_frame_num_value_allowed_flag，等于 1，这时若网络拥塞，编码器可以将编码后的若干图像丢弃，而不用另行通知解码器。在这种情况下，解码器必须有机制将缺失的 frame_num 及所对应的图像填补，否则后续图像若将运动矢量指向缺失的图像将会产生解码错误。

field_pic_flag：这是在片层标识图像编码模式的唯一一个句法元素。所谓的编码模式是指的帧编码、场编码、帧场自适应编码。当这个句法元素取值为 1 时属于场编码，0 时为非场编码。序列参数集中的句法元素 frame_mbs_only_flag 和 mb_adaptive_frame_field_flag再加上本句法元素共同决定图像的编码模式。

​	在序列参数集中，我们已经能够计算出图像的高和宽，但需要指出的是，这个高是指该序列中图像的帧的高度，而一个实际的图像可能是帧也可能是场，对于图像的实际高度，应进一步作如下处理：

​	PicHeightInMbs = FrameHeightInMbs / (1 + field_pic_flag)

​	从而我们可以得到在解码器端所用到的其他与图像大小有关的变量。

​	亮度分量: PicHeightInSamplesL = PicHeightInMbs x 16

​	色度分量: PicHeightInSamplesC = PicHeightInMbs x 8

​	PicSizelnMbs = PicWidthInMbs x PicHeightInMbs

​	前文已提到，frame_num 是参考帧的标识，但是在解码器中，并不是直接引用的frame_num 值，而是引用由frame_num 迸一步计算出来的变量PicNum 的值。

1. MaxPicNum

   表征PicNum的最大值。PicNum和 frame_num 一样，也是嵌在循环中，当达到这个最大值时， PicNum 将从0开始重新计数。

   如果field_pic_flag= 0, MaxPicNum = MaxFrameNum 

   否则，MaxPicNum = 2×MaxFrameNum

2. CurrPicNum

   当前图像的PicNum值。在计算PicNum的过程中，当前图像的PicNum值是由frame_num直接算出。

   如果field_pic_flag= 0, CurrPicNum = frame_num

   否则，CurPicNum= 2xframe_num + 1

   Frame_num是对帧编号的，也就是说，如果在场模式下，同属一个场对的顶场和底场两个图像的frame_num的值是相同的。在帧或帧场自适应模式下，就直接将图像的frame_num赋给PicNum; 而在场模式下，将 2 x frame_num 和 2xframe_num+1两个值分别赋给两个场。2 x frame_num+1 这个值永远被赋给当前场，解码到当前场对的下一个场时，刚才被赋为2xframe_num + 1 的场的PicNum 值被重新计算为 2x frame_num，而将2 xframe_num +1 赋给新的当前场。

bottom_field_flag：等于1时表示当前图像是属于底场，等于0时表示当前图像是属于顶场

idr_pic_id：IDR图像的标识。不同的IDR图像有不同的 idr_pic_id 值。值得注意的是，IDR图像不等价于I 图像，只有在作为IDR图像的 I 帧才有这个句法元素。在场模式下， IDR帧的两个场有相同的 idr_pic_id 值。idr_pic_id 的取值范围是[0，65535]，和frame_num类似，当它的值超出这个范围时，它会以循环的方式重新开始计数。

pic_order_cnt_lsb：在POC的第一种算法中本句法元素来计算POC值，在POC的第一种算法中是显式地传递POC的值，而其他两种算法是通过frame_num来映射POC的值。注意这个句法元素的读取函数是u(v)，这个v的值是序列参数集的句法元素 log2_max_pic_order_cnt_lsb_minus4 加4个比特而得到。 pic_order_cnt_lsb 的取值范围是 [0,MaxPicOrderCntLsb -1]。

delta_pic_order_cnt_bottom：如果是在场模式下，场对中的两个场都各自被构造为一个图像，它们有各自的POC算法来分别计算两个场的POC值，也就是一个场对拥有一对POC值：而在是帧模式或是帧场自适应模式下，一个图像只能根据片头的句法元素计算出一个POC值。根据H.264的规定，在序列中有可能出现场的情况，即 frame_mbs_only_flag不为1时，每个帧或帧场自适应的图像在解码完后必须分解为两个场，以供后续图像中的场作为参考图像。所以当frame_mb_only_flag 不为1时，帧或帧场自适应中包含的两个场也必须有各自的POC值。通过本句法元素，可以在已经解开的帧或帧场自适应图像的POC基础上新映射一个POC值，并把它赋给底场。当然，像句法表指出的那样，这个句法元素只用在POC的第一个算法中。

delta_pic_order_cnt[0],  delta_pic_order_cnt[1]：

​	前文已经提到，POC的第二和第三种算法是从frame_num映射得来，这两个句法元素用于映射算法。delta_pic_order_cnt[0] 用于帧编码方式下的底场和场编码方式的场，delta_pic_order_cnt[1] 用于帧编码方式下的顶场。

redundant_pic_cnt 冗余片的id号，取值范围为[0，127】。向赢J                                                                                                                                                                                                     'rect-spa tial-my_pred_flag 指出在B图像的直接预测的模式下，用时间预测还是用空间预测。1表示空间预测，0表示时间预测。' n矗m_refjdx_active_override-flag 在图像参数集中我们看到已经出现句法元素= num ref idx 10 active minusl-面。um ref idx 11 active minusl指定当前参考帧队列中实际 pl用的参考帧的数目。在片头可以重载这对句法元素，以给某特定图像更大的灵活度。这个句法元素就是指明片头是否会重载，如果该句法元素等于1，下面会出现新的num_ref_iclx_10_active minusl 和 num ref idx 11 active mirrusl值。num ref idx lo active minusl、 num ref idx ll-active minusl  如上个句法元素中所介绍，这是重载的num ref idx lo active_minusl及num_ref idx ll_active rrrinusl。cabac_init_idc 给出cabac初始化时表格的选择，取值范围为(0，2)。slice_qp_delta 指出用于当前片的所有宏块的量化参数的初始值QP.：SliceQPY = 26 + pic_init_qp_minus26 + slice_qp_deltaQPY的取值范围是[0，51」。我们前文已经提到， H.264中量化参数是分图像参数集、片头、宏块头三层给出的．甫两层各自给出一个偏移值，这个句法元素就是片层的偏移。； _4 "sP-fo，.-switch_fjag -指出SP帧币前户宏块的解码万式是否是switching模式，第7章有详细的说明。slice_qs_delta 与slice_qp_delta的与语义相似，用在SI和SP中，由下式计算：QSY = 26 + pic_init_qs_minus26 + slice_qs_deltaQSY的取值是[0，51]。disable_deblocking-filter idc H.264规定一套可以在解码器端独立地计算图像中各边界的滤波强度进行滤波的算法。除了解码器独立计算之外，编码器也可以传递句法元素来干涉滤波强度，这个句法元素指定了在块的边界是否要用滤波，同时指明那个块的边界不用块滤波。slice_alpha_cO_offset div2 给出用于增强a和tco的偏移值：FilterO伪etA = slice_alpha_cO_offset_div2坟 1slice alpha co offset div2' 的范围是[-6，+6)。一-「。eta-offset-div2 给出用于增强B和如的偏移值：FilterO迅etB = slice beta offset_div2女 1slice beta_offset_div2值的范围是[-6，+6]。slice_group_change_cycle 当片组的类型是3、4、5时，由句法元素可获得片组中mapunits的数目：MapUnitsInSliceGroupo = Min(slice_group_change_cyclexSliceGroupChangeRate, PicSizelnMapUnits)slice_group_change_cycle 由 Ceil( Log2( PicSizeInMapUnits -. SliceGroupChangeRate + l ) )位比特表示slice_group_change_cycle值的范围是[O,Ceil( PicSizeInMapUnits~SliceGroupChangeRate )]。其中， Ceil㈨函数返回不小于x的最小整数。



#### 参考图像序列重排序的语义

每一个使用帧间预测的图像都会引用前面已解码的图像作为参考帧。如前文所述，编码器给每个参考帧都会分配一个唯一性的标识，即句法元素如mem岣。但是，当编码苻要指定当前图像的参考图像时，并不是直接指定该图像的如me_num值，而是使用通过下面步骤最终得出的ref_id号，如图6.8所示。其中，从frame num到变换到变量PicNum主要是考虑到场模式的需要，当序列中允许出现场时，每个非场的图像<帧或帧场自适应）解码后必须分解为一个场对，从贡需要为它们分解后的两个场各自指定一个标识：进一步从PicNum到ref_id是为了能节省码流，因为PicNum的值通常都比较大，而在帧间预测时，需要为每个运动矢量都指明相对应的参考帧的标识，如果这个标识选用PicNum，开销就会比较大，所以H.264又将PicNum映射为一个更小的变量ref_id。在编码器和解码器都同步地维护一个参考帧队列，每解码一个片就将该队列刷新一次，把各图像按照特定的规则进行排序，排序后各图像在队列中的序号就是该图像的ref_id值。在下文中，我们可以看到在宏块层表示参考图像的标识就是ref_id，在第7章我们会详细讲述队列的初始化、排序等维护算法。维护队列时两个重要操作：重排序( Reordering)和标记( Marking)所用到的句法元素。说明：句法元素的后缀名带有“10 ”指的是第一个参数列表：句法元素的后缀名带有“11”指的是第=个参数列表<用在B帧预测中)。ref_pic_list_reorderin g-flag_10 指明是否进行重排序操作。这个句法元素等于1时，表明紧跟着会有一系列句法元素用于参考帧队列的重排序。refjjc_lis t_reorderin g-flag-l】 与上个句法元素的语义相同，只是本句法元素用于参考帧队列Ll。reordering_of_pic_nums_idc 与句法元素abs_面t'_pic_nm minusl 或long_terrn_pic_num配合，指明执行哪种重排序操作，具体语义见表6.23cabs_diff_pic_num minusl 在对短期参考帧重排序时指明重排序图像与当前图像预测值的差值，取值范围是[O， MaxPicNum - l]，见表6.23。long_term_pic_num 在对长期参考帧重排序时指明重排序图像。见表6.23。从上文可以看到，每组reorder啦of_pic_nums_idc、abs_diff_pic_nu_minusl 或reordering-of-pic-nums idc、 long_term_pic_num只能对一个图像操作，而通常情况下都需要对一组图像重排序，所以在码流中一般会有个循环，反复出现这些重排序的句法元素，如图6.9所示，循环直到reordering_of_pic_nms_idc等于3结束，我们在表6.22中也可以看到这种情况。



#### 加权预测的语义

加权预测句法元素的语义如下：luma_log2_weight_denom 给出参考帧列表中参考图像所有亮度的加权系数，取值范围是[0,7]。chroma_log2_weight_denom 给出参考帧列表中参考图像所有色度的加权系数，取值范围是[0，7」。Ima_weight]0_flag 其值等于1时，指的是在参考图像列表0中的亮度的加权系数存在：等于0时，在参考图像列表0中的亮度的加权系数不存在。luma_weight_10[ i ]  用参考序列0预测亮度值时，所用的加权系数，取值范围是[一128,127]。如果luma_weight_10_flag is = O，对于RefPicListo[ i 」的luma weight-10[i」= 21uma-log2-weighLddenomuma-otTset_10[ i』 用参考序列0预测亮度值时，所用的加权系数的额外偏移。luma offset_10[i] 的取值范围是[-128,127]。如果luma_weight_10_flag = 0，对于RefPicListo[ i】chroma we12ht_10 日畠chroma  weight_10_flag.   chroma_weight]01111j l、 c如roma  offset]0【 i   j l与上述三个类似，不同的是这三个句法元素是用在色度预测。luma_weight_ll_flag 、   Iuma_weight_ll 、  Iuma offset 11 、  chroma_weight_ll_flag 、chroma-weight-ll、 chroma offset_ll等句法元素与luma-weight-10-日ag, luma weight-10、luma o伪et_10、chroma weight_10_flag, chroma_weight_10、chroma offset_10的语义相似'不同点是这几个句法元素是用在参考图像列表1中。

#### 参考图像序列标记(Marking)操作的语义

前文介绍的重排序( Reordering)操作是对参考帧队列重新排序，而标记<Marking)操作负责将参考图像移入或移出参考帧队列。no-output_of_prior_pics_flag 仅在当前图像是IDR图像时出现这个句法元素，指明是否要将前面已解码的图像全部输出。long_term_reference_日ag 与上个图像一样，仅在当前图像是IDR图像时出现这一句法元素。这个句法元素指明是否使用长期参考这个机制。如果取值为』，表明使用长期参考，并H每个IDR图像被解码后自动成为长期参考帧：否则取值为0， IDR图像被解码后自动成为短期参考帧。adap tive_ref_pic_m arkin g_mo de_flag 指明标记( Marking)操作的模式，具体语义见表6.24。memory_management control_operation 在自适应标记( Marking)模式中，指明本次操作的具体内容，具体语义见表6.25。difference_of_pic_nums_minusl 当memory_management_control_operation等于3或 1时，由这个句法元素可以计算得到需要操作的图像在短期参考队列中的序号。参考帧队列中必须存在这个图像。long-term-p】c-num 当memory-management-control-operation值等于2时，从此句法元素中得到所要操作的长期参考图像的序号。long_term_frame_idx 当memory_management_control_operation等于3或6，分配一个长期参考帧的序号给一个图像。白  max-long-terrn_frame_idx_plusl 此句法元素的值减1，指明长期参考队列的最大数目。 max_long_term_fiame_idx_p】usl的取值范围是[O,num_ref_frameS]。

#### 片数据的语义

片数据句法的语义如下：cabac_alignment_onebit 当熵编码模式是CABAC时，此腓勳擞据字弼脐，即数据从下一个字节的第一个比特开始，如果还没有字节对齐，将出现若干个cabac_alignment_one_bit作为填充。mb_skip_run 当图像采用帧间预测编码时， H.264允许在图像平坦的区域使用“跳跃”块，“跳跃”块本身不携带任何数据，解码器通过周围已重建的宏块的数据来恢复“跳跃”块。当熵编码为CAVLC或CABAC时，“跳跃”块的表示方法不同。当entropy_coding_mode日ag为1，即熵编码为CABAC 时，是每个“跳跃”块都会有句法元素mbskip_flag 指明：当entropycoding_mode_flag等于0，即熵编码为CAVLC时，用一种行程的方法给出紧连着的“跳跃”块的数目，即句法元素mbskip_runo mb_skip_run 的取值范围[O，PicSizelnMs - Cu姚屁Addrl.mb_sldp_flag 指明当前宏块是否是跳跃编码模式的宏块。mb-field_decodingflag 在帧场自适应图像中，指明当前宏块所属的宏块对是帧模式还是场模式。mb_field_decoding-flag等于O，则当前宏块对是帧宏块对：等于1，该宏块对是一个场宏块对。如果一个宏块对的两个宏块句法结构中都没有出现这个句法元素，即它们都是“跳跃”块时，本句法元素由以下决定：(1) 如果这个宏块对与相邻的、左边的宏块对属于同一个片时，这个宏块对的mb field decoding_flag的值等于左边的宏块对的mbfield_decoding_flag的值：(2) 否则，这个宏块对的mb_field decoding_flag 的值等于上边同属于一个片的宏块对的mb field decoding_flag的值;(3) 如果当前宏块对的左边和上方都没有邻居宏块对，这个宏块对的mbfield_decodin9-flag的值等于O，即帧模式。end_of_slice_flag 指明是否到了片的结尾。

#### 宏块层的语义

m b_type 指明当前宏块的类型。H.264规定，不同的片中允许出现的宏块类型也不同。在各种片类型中允许出现的宏块种类见表6.26。可以看到，I片中只允许出现1宏块，而P片中既可以出现P宏块也可以出现1宏块。也就是说，在帧间预测的图像中也可以包括帧内预测的图像。其他片也有类似情况。更进一步来看，H.264也定义了比以往视频编码标准更多的宏块类型。具体来说，在帧间预测模式下，宏块可以有7种运动矢量的划分方法。在帧内预测模式下，如果是帧内16 ×16预测，宏块有4种预测方法，即4种类型：如果是帧内4×4预测，这时每个4×4块可以有9种预测方法，整个宏块共有144种类型。mb_type并不能描述以上所有有关宏块类型的信息。mb_type作为出现在宏块层的第一个句法元素，它描述跟整个宏块有关的基本的类型信息。在不同的片中， mb_type的定义是不同的，下面我们分别讨论【、 P、B片中这个句法元素的意义。(1) I片中的mb_type，具体语义见表6.27。表中， Intra 4×4表示使用帧内4×4预测， Intra 16×16表示使用帧内16×16预测。当使用帧内16×16时，类型名称由了如下的结构组成：I_16× 16_x_Y-z其中，x对应于表中“帧内16×16的预测模式”字段的值，y对应于表中“色度CBP”字段的值，z对应于表中“亮度CBP ”的值。①帧内16 ×16的预测模式：当使用帧内16 ×16预测时，指定使用何种预测方式，帧内16×16共有4种预测模式，第7章中会详细介绍这些预测模式的算法。②CodedBlockPatternLuma: 指定当前宏块色度分量的CBP, CBP (CodedBlockPattern)是指子宏块残差的编码方案。该变量详细语义见coded block-pattern条目。③ 亮度CBP: 指定当前宏块亮度分量的CBP，详细语义见coded block_pattern条目。我们看到，帧内16 ×16宏块类型的mb_type语义原比其他宏块类型的复杂，这是因为当使用帧内16 ×16时，整个宏块是一个统一的整体，宏块中各子宏块、4×4小块的预测模式息都是相同的，所以可以把这些信息放入mb_type，以减少码流。其他宏块类型的这些信息必须在各子块中另外用句法元素指明。(2) P片中的mb_type，具体语义见表6.28。在表6.28中，Pred_LO表示用参考列表LO，即前向预测。P片中的宏块类型可参见表6.28和表6.27。当mb_type值为0～4时， mb_type的含义见表6.28; 当mb_type值为5～30时，mb_type的含义见表6.27，用mb_type值减5所得值来进行查找。预测模式(mb_type， n）预测模式是mb_type的函数，n是宏块的第n个分区。(3) B片中的mb_type，其具体语义见表6.29。B片中的宏块类型可参见表6.29和表6.27。如果当前宏块是属于B片且mb_type值为0 ---22， rnb-type的含义见表6.29; 当mb_type值为23～48时，mb_type的含义见表6.27，用mb_type值减23所得值来进行查找。表中， Pred_LO表示使用LO，即前向预测：Pred_Ll表示使用Ll，即后向预测：Bipred表示双向预测： Direct表示直接预测模式。预测模式(mb_type，n)是mb_type的函数，n是宏块的第n个分区。pcm_alignment_zero_bit 其值等于0。pcm-byte【 i 】 像素值。前256个pcm_byte[ i 」的值代表亮度像素的值，下一个( 256 x( ChromaFormatFactor-l))/2 今p坤-bytef i 」的值代表Cb分量的值。最后一个( 256 x ( ChromaFormatFactor-l） )/2'企pcm_byte[ i]的值代表Cr分量的值。coded-block_attern 即CBP，指亮度和色度分量的各小块的残差的编码方案，所谓编码方案有以下几种：(1>所有残差<包括DC、AC)都编码；(2)只对DC系数编码：(3)所有残差<包括DC、AC)都不编码。这个句法元素同时隐含了一个宏块中亮度、色度分量的CBP，所以第一步必须先分别解出各分量各自CBP的值。其中，两个色度分量的CBP是相同的。变量CodedBlockPatternLuma是亮度分量的CBP，变量CodedBlocPattemChroma是色度分量的CBP。对于非Intra_16×16的宏块类型：CodedBlockPatternLu、a = coded_block_pattern % 16CodedBlockPatternChroma = coded block_pattern/16对于Intra_16×16宏块类型，CodedBlockPatternLuma和CodedBlockPatternChroma的值不是由本句法元素给出，而是通过mb_type得到。①CodedBlockPatternLuma：是一个16位的变量，其中只有最低四位有定义。由于非Intra_16×16的宏块不单独编码DC系数，所以这个变量只指明两种编码方案：残差全部编码或全部不编码。变量的最低位比特从最低位开始，每一位对应一个子宏块，该位等于1时表明对应子宏块残差系数被传送：该位等于0时表明对应子宏块残差全部不被传送，解码器这些残差系数赋为0。②CodedBlockPattemChroma: 当值为0、1、2时有定义，见表6.30。mb_qp_delta 在宏块层中的量化参数的偏移值。mb_qp_delta值的范围是[-26， +25」。量化参数是在图像参数集、片头、宏块分三层给出的，最终用于解码的量化参数由以下公式得到：QPY = (QPY,PREV + rnb_qp_delta + 52 ) % 52其中，QPY，PREV是当前宏块按照解码顺序排列的前一个宏块的量化参数，我们可以看到，mb_qp_delta所指示的偏移是前后两个宏块之间的偏移。片中第一个宏块的QPY，PREV是由下式给出：QPY,PREV -- 26 + pic_init_qp_minus26 + slice_qp_delta

#### 宏块预测的语义

prev_intra4×4_pred_mode_flag[luma4×4BlkIdx 』 rem_intra4×4_pred  mode[luma4×4Blkldx l帧内预测模式也是可以预测的，句法元素prev intra4×4-pred-mode_flag用来指明帧内预测中亮度分量的预测模式的预测值是否是实际预测模式。如果是，就不需另外再传预测模式：如果不是，就由rem_intra4 ×4_pred_mode指定实际预测模式。intra_chroma_pred_mode 在帧内预测时指定色度的预测模式，具体语义见表6.31，ref_idx_10[ mbPartIdx ]  用参考帧列表LO进行预测时，即前向预测时，参考图像在参，考帧列表中的序号。其中mbPartIdx是宏块分区的序号。如果当前宏块是非场宏块，则ref_idx_10【 mbPartIdx」值的范围是[0， num_ref_idx_10-active minrrsll。如果当前宏块是场宏块<宏块所在图像是场，当图像是帧场自适应时当前宏块处于场编码的宏块对)， ref_idx_10【 mbPartIdx ]值的范围是0到2xnu_ref_idx 10 active_minusl + l,如前所述，此时参考帧队列的帧都将拆成场，故参考队列长度加倍。ref_idx_ll[ mbPartldxl 语义同上，只是这个句法元素用于参考帧列表Ll，即后向预测。mvd_10[ mbPartIdx110』f compIdx ]  运动矢量的预测值和实际值之间的差。 mbPartIdx是宏块分区的序号。compIdx = 0时为水平运动矢量，compIdx = 1时为垂直运动矢量。mvdll[ mbPartIdx』10HcompIdx』 语义同上，只是这个句法元素用于Ll，即后向预测。

#### 子宏块预测的语义

子宏块预测的句法元素的语法如下：sub-mb_type[ mbPartIdx』 指明子宏块的预测类型，在不同的宏块类型中，这个句法元素的语义不一样。(1) P宏块P宏块中的子宏块类型见表6.32。(2）B宏块B宏块中的子宏块类型见表6.33。ref_idx_10『 mbPartIdx』与6.3.10节中定义的ref_idx_10相同。ref_idx_ll[ mbPartIdx l 与6.3.10 节中定义的ref idx_ll 相问。mvd_10【 mbPartIdx』【subbPartIdx11compIdx」 与6.3.10节中定义mvd_10相同，除了subMbPartIdx<子宏块中的索引值)。mvd_ll【 mbPartIdx H subMbPartIdx 11 compldx l  同上，用于Ll。

#### 用 CAVLC 方式编码的残差数据的语义

coeff token  指明了非零系数的个数，拖尾系数的个数。trailing_ones_sign_flag拖尾系数的正负符号。如果trailing_ones_sign_flag = 0，相应的拖尾系数是+1;如果trailing_ones_sign_flag =1，相应的拖尾系数是-l。level_prefix和level_suffix分别表示非零系数值的前缀和后缀。totaLzeros 系数中0的总个数。run_before 在非零系数之前连续零的个数。

#### 用CABAC方式编码的残差数据的语义

coded block_flag 指出当前块是否包含非零系数。如果coded block_flag= O，这个块不包含非零系数：如果coded block_flag=1，这个块包含非零系数。significant_coeff_flag[ i』 指出在位置为i处的变换系数是否为零。如果significant_eoeff_flag[ i =0，在位置为i处的变换系数为零：如果significant_coeff_flag[ i」 =1，在位置为i处的变换系数不为零。last_significant coeff_flaglil 表示当前位置i处的变换系数是否为块中最后一个非零系数。如果last_significant coeff_flag[ i」 =1，这个块中随后的系数都为零：否则，这个块中随后的系数中还有其他的非零系数，coe吖abs level minusl【i] 系数的绝对值减l。coeff_sign_flag[ i』 系数的符号位。coeff_sign_flag = 0，，正数：coeffsign_flag=l， 负数。

