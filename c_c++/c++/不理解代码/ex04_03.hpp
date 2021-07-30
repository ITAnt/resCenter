//用于模板型模板参数的模板
template<typename T, int i> struct S1;

//模板通例，有三个模板参数，分别是类型参数，非类型参数及模板型参数
template<typename T, int i, template<typename, int> class SP>
struct S;

//特例1，可匹配S<char, 任意整数, S1>
template<int i, template<typename, int> class SP>
struct S<char, i, SP>;

//特例2，可匹配S<任意有const修饰的类型, 任意整数, S1>
template<typename T, int i, template<typename, int> class SP>
struct S<const T, i, SP>;

//特例3，完全特例，只能匹配S<char, 10, S1>
template<>
struct S<char, 10, S1>;

//特例4，以模板实例作为类型参数值。匹配S<S1<任意类型, 10>, 10, S1>
template<typename T>
struct S<S1<T, 10>, 10, S1>;

//特例5，错误！匹配式项目数与通例参数数不一致
// template<typename T, int i, template<typename, int> class SP, typename TT>
// struct S<T, i, SP, TT>;

//特例6，错误！匹配式项目类型与通例参数类型不同
// template<typename T>
// struct S<char, 10, T>;

//特例7，错误！模板型参数SP与通例中SP类型不一致
// template<typename T, int i, template<typename> class SP>
// struct S<const T, i, SP>;
