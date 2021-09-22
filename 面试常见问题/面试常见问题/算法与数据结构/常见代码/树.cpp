#include <string>
#include <iostream>

using namespace std;
//元素
typedef struct Book{        //元素
    string id;
    string name;
    double price;
}Book;

typedef struct BiNode       //二叉树节点
{
    Book data;
    BiNode *lchild;
    BiNode *rchild;
}BiTNode,*BiTree;

typedef struct LStack
{
    Book data;
    struct LStack *next;
}LStack,*LStackList;



//中序遍历
void InOrderTraverse(const BiTree &root)
{
    if(root == NULL)
        return;

    InOrderTraverse(root->lchild);
    InOrderTraverse(root->rchild);
    cout<< root->data.name <<endl;
}

void InitLStack(LStackList &s)
{
    s =NULL;
}

bool StackEmpty(LStackList &s)
{
    if(s == NULL)
        return true;
    return false;
}

void Pop(LStackList S,BiTree s)
{

}

void Push(LStackList S,BiTree s){

}

//循环遍历的方式中序遍历
void InOrderTraverse1(const BiTree root)
{
    LStackList S;
    InitLStack(S);
    BiTree q = new BiTNode;
    BiTree p = root;
    while( p || !StackEmpty(S)){
        if(p){
            Push(S,p);
            p = p->lchild;
        }else{
            Pop(S,q);
            cout<<q->data.name<<endl;
            p=q->rchild;
        }
    }

}

void CreateBiTree(BiTree T)        //二叉树创建
{
    char ch;
    cin>>ch;
    if(ch =='#'){
        T =NULL;
        return;
    }else{
        T = new BiTNode;
        T->data.name= ch;
        CreateBiTree(T->lchild);
        CreateBiTree(T->rchild);
    }
}

int Depth(BiTree T)     //二叉树深度
{
    int m=0,n=0;
    if(T == NULL){
        return 0;
    }else{
        m = Depth(T->lchild);
        n = Depth(T->rchild);
        if(m>n) return (m+1);
            else return (n+1);
    }
}

int NodeCount(BiTree T)     //节点个数
{
    if(T == NULL)
        return 0;
    else
        return (NodeCount(T->lchild) + NodeCount(T->rchild)+1);
}

typedef struct LBiTNode{
    Book data;
    int LTag;
    int RTag;
    struct LBiTNode *lchild;
    struct LBiTNode *rchild;
}LBiTNode,*LBiTree;


LBiTree pre = new LBiTNode; //需要赋值
//pre->RTag=1;
//pre->rchild=NULL;
//二叉线索树
void InThreading(LBiTree T){
    if(T){
        InThreading(T->lchild);
        if(!T->lchild){
            T->LTag =1;
            T->lchild = T;
        }else{
            T->LTag = 0;
        }

        if(!pre->rchild){
            pre->RTag = 1;
            pre->rchild = T;
        }else{
            pre->RTag = 0;
        }
        pre = T;
        InThreading(T->rchild);
    }
}

typedef struct hafmanTNode
{
    int weight;
    int parent,lchild,rchild;
}hafmanTNode,*hafmanTree;

void Select(hafmanTree h,int n,int &s1,int &s2)
{
    int min1 = 0x7fffffff,min2 = 0x7fffffff;
    for(int i=1;i<n;i++){
        if(h[i].weight < min1 && h[i].parent ==0){
            min1 = h[i].weight;
            s1 = i;
        }
    }
    //临时调整值，使得循环更便捷
    int temp = min1;    //临时存储
    h[s1].weight = 0x7fffffff;
    for(int i=1;i<n;i++){
        if(h[i].weight < min2 && h[i].parent ==0){
            min2 = h[i].weight;
            s2 = i;
        }
    }
    h[s1].weight = temp;
}

void CreateHafmanTree(hafmanTree &h,int n)
{
    int m,s1,s2;
    if(n<=1)
        return;
    m = 2*n-1;
    h = new hafmanTNode[m+1];   // h[0] 不存储
    
    for(int i=1;i< m;i++){
        h[i].weight = 0;
        h[i].parent = 0;
        h[i].lchild = 0;
        h[i].rchild  =0;
    }
    cout<<"请输入"<<n<<"个数据来构建哈夫曼树"<<endl;
    for(int i=1;i<n;i++)
    {
        cin>>h[i].weight;   //录入数据
    }
    
    //构建哈夫曼树
    //获取最小的两个未使用过的数
    for(int i=n+1;i<m;i++){
        Select(h,i-1,s1,s2);
        h[s1].parent = i;
        h[s2].parent = i;
        h[i].lchild = s1;
        h[i].rchild = s2;
        h[i].weight = h[s1].weight +h[s2].weight;
    }
}