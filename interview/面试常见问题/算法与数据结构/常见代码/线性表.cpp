//顺序表结构
typedef struct SqList{    //顺序表
    Book *elem;
    int length; //存储当前数据的长度
}SqList;


typedef struct LNode{   //单链表
    Book *data;
    struct LNode *next;
}LNode,*LinkList;

typedef struct DuLNode{     //双向链表
    Book data;
    struct DuLNode *next;
    struct DuLNode *prior;
}DuLNode,*DuLinkList;

typedef struct SqDeList{
    Book *elem;
    int front;
    int rear;   //仅仅是下标，顺序表下标
}SqDeNode;

typedef struct SqStack{
    Book *base;
    Book *top;
    int stacksize;
}SqStack;

typedef struct LStack{  //头插法入栈
    Book data;
    LStack *next;
}LStack,*LNodeStack;


void TraverseList(LinkList& p){     //递归方法
    if(p == NULL)
        return;
    cout << p->data <<endl;
    TraverseList(p->next);
}
void move(char A,int n,char C)
{
    
}

void Hanoi(int n,char A,char B,char C)
{
    if(n == 1)
        move(A,1,C);
    else
    {
        Hanoi(n-1, A, C, B);
        move(A,n,C);
        Hanoi(n-1, B, A, C);
    }
}


typedef struct DuSqList{        //循环队列，(rear+1)%MAXSIZE
    Book *data;
    int front;
    int rear;
}DuSqList;

typedef struct DuQuNode{
    Book data;
    DuQuNode *next;
}DuQuNode,*DuQuPtr;

typedef struct DuQuLink{    //链队，头插法
    DuQuPtr *front;
    DuQuPtr *rear;
}DuQuLink;

typedef struct LStackNode{  //链栈，头插法(头部为栈)
    Book data;
    LStackNode *next;
}stackNode,*stackLink;

/*
	操作：
		初始化
		插入
		删除
		获取指定位置元素
		查找指定元素是否存在
*/