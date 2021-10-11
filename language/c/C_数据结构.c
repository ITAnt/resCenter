数据结构常见代码

顺序表：
struct Book
{
	string id;
	string name;
	double price;		//定价
};

typedef struct{
	Book *elem;	//存储空间的基地址
	int length;	//当前长度
} SqList;

SqList &L;
L.elem = new Book[MAXSIZE];


单链表
struct Elem {
	string id;
	string name;
};
typedef struct LNode {
	Elem data; //结点的数据域
	struct LNode *next; //结点的指针域
} LNode, *LinkList; //LinkList为指向结构体LNode的指针类型

Status InitList_L(LinkList &L)
{
	L = new LNode;
	L->next = NULL;
	return OK;
}
//前插法创建链表
void CreateList_H(LinkList &L,int n){
	LNode p;
	while()
	{
		p = new LNode;
		p->next = L->next;
		L->next = p;
		length++;
	}
}


双链表
typedef struct DuLNode {
	Elem data; //数据域
	struct DuLNode *prior; //直接前驱
	struct DuLNode *next; //直接后继
} DuLNode, *DuLinkList;

Status InitDuList_L(DuLinkList &L) {
	//构造一个空的双向链表L
	L = new DuLNode; //生成新结点作为头结点，用头指针L指向头结点
	L->next = NULL; //头结点的指针域置空
	L->prior = NULL;
	return OK;
}

void CreateDuList_L(DuLinkList &L) {
	//正位序输入n个元素的值，建立带表头结点的双向链表L，同时建立前驱指针
	DuLinkList r, p;
	L = new DuLNode;
	L->next = NULL; //先建立一个带头结点的空链表
	r = L;//尾指针r指向头结点
	length = 0;
	while () {
		p = new DuLNode; //生成新结点
		p->next = NULL;
		r->next = p; //插入到表尾
		r = p; //r指向新的尾结点
		p->prior = L; //插入到表头
		length++;
	}
} //CreateDuList_L


顺序栈
typedef struct {
	SElemType *base;//栈底指针
	SElemType *top;//栈顶指针
	int stacksize;//栈可用的最大容量
} SqStack;

S.base = new SElemType[MAXSIZE];//为顺序栈动态分配一个最大容量为MAXSIZE的数组空间
if (!S.base)
	exit(OVERFLOW); //存储分配失败
S.top = S.base; //top初始为base，空栈
S.stacksize = MAXSIZE;

S.top++ = e;	//入栈
e = --S.top		//出栈


链栈
typedef struct StackNode {
	SElemType data;
	struct StackNode *next;
} StackNode, *LinkStack;


顺序队列
typedef struct {
	QElemType *base;//初始化时动态分配存储空间
	int front;//头指针
	int rear;//尾指针
} SqQueue;

Q.rear = (Q.rear + 1) % MAXQSIZE;	//队尾指针加 1

链表队列
typedef struct QNode {
	QElemType data;
	struct QNode *next;
} QNode, *QueuePtr;
typedef struct {
	QueuePtr front; //队头指针
	QueuePtr rear; //队尾指针
} LinkQueue;


栈应用----表达式求值
运算符栈和数据栈，运算符栈顶运算符优先级更高，则数据栈出栈两数进行计算，然后将结果入栈到数据栈
char EvaluateExpression() {//算术表达式求值的算符优先算法，设OPTR和OPND分别为运算符栈和操作数栈
	LinkStack OPTR, OPND;
	char ch, theta, a, b, x, top;
	InitStack(OPND); //初始化OPND栈
	InitStack(OPTR); //初始化OPTR栈
	Push(OPTR, '#'); //将表达式起始符“#”压入OPTR栈
	cin >> ch;
	while (ch != '#' || (GetTop(OPTR) != '#')) //表达式没有扫描完毕或OPTR的栈顶元素不为“#”
	{
		if (!In(ch)) {
			Push(OPND, ch);
			cin >> ch;
		} //ch不是运算符则进OPND栈
		else
			switch (Precede(GetTop(OPTR), ch)) //比较OPTR的栈顶元素和ch的优先级
			{
			case '<':
				Push(OPTR, ch);
				cin >> ch; //当前字符ch压入OPTR栈，读入下一字符ch
				break;
			case '>':
				Pop(OPTR, theta); //弹出OPTR栈顶的运算符
				Pop(OPND, b);
				Pop(OPND, a); //弹出OPND栈顶的两个运算数
				Push(OPND, Operate(a, theta, b)); //将运算结果压入OPND栈
				break;
			case '=': //OPTR的栈顶元素是“(”且ch是“)”
				Pop(OPTR, x);
				cin >> ch; //弹出OPTR栈顶的“(”，读入下一字符ch
				break;
			} //switch
	} //while
	return GetTop(OPND); //OPND栈顶元素即为表达式求值结果
}



字符串

字符串匹配算法
int Index(SString S[],SString T[],int pos)
{
	//返回模式T在主串S中第pos个字符之后第s一次出现的位置。若不存在，则返回值为0
	//其中，T非空，1≤pos≤StrLength(S)
	int i = pos;
	int j = 1;
	while(i <= S[0]&&j <= T[0])
	{
		if(S[i]==T[j])
		{
			++i;
			++j;
		} //继续比较后继字符
		else
		{
			i=i-j+2;
			j=1;
		} //指针后退重新开始匹配
	}
	if (j > T[0])
		return i - T[0];
	else
		return 0;
	return 0;
}//Index


KMP 字符串匹配算法1
//计算next函数值
void get_next(SString T, int next[])
{ //求模式串T的next函数值并存入数组next
	int i = 1, j = 0;
	next[1] = 0;
	while (i < T[0])
		if (j == 0 || T[i] == T[j])
		{
			++i;
			++j;
			next[i] = j;
		}
		else
			j = next[j];
}//get_next

//KMP算法
int Index_KMP(SString S, SString T, int pos, int next[])
{ 	// 利用模式串T的next函数求T在主串S中第pos个字符之后的位置的KMP算法
	//其中，T非空，1≤pos≤StrLength(S)
	int i = pos, j = 1;
	while (i <= S[0] && j <= T[0])
		if (j == 0 || S[i] == T[j]) // 继续比较后继字
		{
			++i;
			++j;
		}
		else
			j = next[j]; // 模式串向右移动
	if (j > T[0]) // 匹配成功
		return i - T[0];
	else
		return 0;
}//Index_KMP


KMP 字符串匹配算法2
//算法4.4　计算next函数修正值
void get_nextval(SString T, int nextval[])
{ // 求模式串T的next函数修正值并存入数组nextval
	int i = 1, j = 0;
	nextval[1] = 0;
	while (i < T[0])
		if (j == 0 || T[i] == T[j])
		{
			++i;
			++j;
			if (T[i] != T[j])
				nextval[i] = j;
			else
				nextval[i] = nextval[j];
		} else
			j = nextval[j];
}//get_nextval

//算法4.2　KMP算法
int Index_KMP(SString S, SString T, int pos, int next[])
{ 	// 利用模式串T的next函数求T在主串S中第pos个字符之后的位置的KMP算法
	//其中，T非空，1≤pos≤StrLength(S)
	int i = pos, j = 1;
	while (i <= S[0] && j <= T[0])
		if (j == 0 || S[i] == T[j]) // 继续比较后继字
		{
			++i;
			++j;
		}
		else
			j = next[j]; // 模式串向右移动
	if (j > T[0]) // 匹配成功
		return i - T[0];
	else
		return 0;
}//Index_KMP


树

void CreateBiTree(BiTree &T){	
	//按先序次序输入二叉树中结点的值（一个字符），创建二叉链表表示的二叉树T
	char ch;
	cin >> ch;
	if(ch=='#')  T=NULL;			//递归结束，建空树
	else{							
		T=new BiTNode;
		T->data=ch;					//生成根结点
		CreateBiTree(T->lchild);	//递归创建左子树
		CreateBiTree(T->rchild);	//递归创建右子树
	}								//else
}									//CreateBiTree

void InOrderTraverse(BiTree T){  
	//中序遍历二叉树T的递归算法
	if(T){
		InOrderTraverse(T->lchild);
		cout << T->data;
		InOrderTraverse(T->rchild);
	}
}
//用算法5.3 先序遍历的顺序建立二叉链表
void InOrderTraverse(BiTree T){  
	//先序遍历二叉树T的递归算法
	if(T){
		cout << T->data;
		InOrderTraverse(T->lchild);
		InOrderTraverse(T->rchild);
	}
}

//树的深度
int Depth(BiTree T)
{ 
	int m,n;
	if(T == NULL ) return 0;        //如果是空树，深度为0，递归结束
	else 
	{							
		m=Depth(T->lchild);			//递归计算左子树的深度记为m
		n=Depth(T->rchild);			//递归计算右子树的深度记为n
		if(m>n) return(m+1);		//二叉树的深度为m 与n的较大者加1
		else return (n+1);
	}
}

//结点的个数
int NodeCount(BiTree T)
{
     if(T==NULL) return 0;  			// 如果是空树，则结点个数为0，递归结束
     else return NodeCount(T->lchild)+ NodeCount(T->rchild) +1;
     //否则结点个数为左子树的结点个数+右子树的结点个数+1
} 


//二叉树线索化
void InThreading(BiThrTree p)
{
	//pre是全局变量，初始化时其右孩子指针为空，便于在树的最左点开始建线索
	if(p)
	{
		InThreading(p->lchild);             			//左子树递归线索化
		if(!p->lchild)
		{                   							//p的左孩子为空
			p->LTag=1;                                 	//给p加上左线索
			p->lchild=pre; 								//p的左孩子指针指向pre（前驱）
		} 
		else
			p->LTag=0;
		if(!pre->rchild)
		{												//pre的右孩子为空
			pre->RTag=1;                   				//给pre加上右线索
			pre->rchild=p;                     			//pre的右孩子指针指向p（后继）
		}
		else
			pre->RTag=0;
		pre=p;                       					//保持pre指向p的前驱
		InThreading(p->rchild);               			//右子树递归线索化
    }
}//InThreading

//哈夫曼树    哈夫曼编码
//表达式求值

图


//快排
int partition(int arr[],int low,int high)
{
	int key;
	key = arr[low];
	while(low < high)
	{
		while(low < high && arr[high] >= key )
			high--;
		if(low < high)
			arr[low++] = arr[high];
		while(low < high && arr[low] <= key)
			low++;
		if(low < high)
			arr[high--] = arr[low];
	}
	arr[low]  = key;
	return low;
}

void quick_sort(int arr[], int start, int end)
{
	int pos;
	if (start < end)
	{  
		pos = partition( arr, start, end);
		quick_sort(arr,start,pos-1);
		quick_sort(arr,pos+1,end);
	}         

	return ;
}


//二路归并排序
void merge(int arr[], int low, int mid, int high)
{
        int i, k;
        int *tmp = (int *) malloc((high-low+1) * sizeof(int)); 
//申请空间，使其大小为两个
        int left_low = low;
        int left_high = mid;
        int right_low = mid + 1;
        int right_high = high;
 
        for (k = 0; left_low <= left_high && right_low <= right_high; k++)  //比较两个指针所指向的元素
        { 
            if(arr[left_low]<=arr[right_low])
            {	
				tmp[k] = arr[left_low++];
            }
            else
            {   
				tmp[k] = arr[right_low++];
            }
        }
	

        if(left_low <= left_high) 
//若第一个序列有剩余，直接复制出来粘到合并序列尾
        {
		//	memcpy(tmp+k, arr+left_low, (left_high-left_low+1)*sizeof(int));
			for(i=left_low;i<=left_high;i++)
				tmp[k++] = arr[i];
        }

        if(right_low <= right_high)
 //若第二个序列有剩余，直接复制出来粘到合并序列尾
        {
		//	memcpy(tmp+k, arr+right_low, (right_high-right_low+1)*sizeof(int));
			for(i=right_low;i<=right_high;i++)
				tmp[k++] = arr[i];
        }
	for(i=0;i<high-low+1;i++)
		arr[low+i] = tmp[i];

        free(tmp);

		return ;
}

void merge_sort(int arr[], unsigned int first, unsigned int last)
{
        int mid = 0;
        if(first<last)
        {
                mid = (first+last)/2; /*注意防止溢出*/
                /*mid = first/2 + last/2;*/
                //mid = (first & last) + ((first ^ last) >> 1);
                merge_sort(arr, first, mid);
                merge_sort(arr, mid+1,last);
                merge(arr,first,mid,last);
        }

		return ;
}


//二分查找
int binarySearch(int a[] , int n, int key) 
{
	int low = 0;
	int high = n - 1;
	while (low <= high) 
	{
		int mid = (low + high)/2;
		int midVal = a[mid];
		if (midVal < key)
			low = mid + 1;
		
		else if (midVal > key)
			high = mid - 1;          
		else
			return mid;      
	}
	
	return -1;    
}