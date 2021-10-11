#include <iostream>

using namespace std;
#define ENDCHAR '#'

//顺序查找
typedef struct{
    int key;    //关键字域
}ElemType;

typedef struct{     //顺序表结构
    ElemType *r;
    int length;
}SStable;

typedef struct BSTNode{     //二叉树
    ElemType data;
    struct BSTNode *lchild;
    struct BSTNode *rchild;
}BSTNode,*BSTree;

int Search_bin1(SStable &s,int key)     //二分查找
{
    int low=0,high=s.length-1,mid;
    while(low<high){
        mid = (low+high)/2;
        if(s.r[mid].key == key)
            return mid;
        else if(s.r[mid].key > key)
            high = mid-1;
        else
            low = mid+1;
    }
    return -1;
}

void Insert_BST(BSTree &t,char key)     //二叉排序树插入
{
    if(t == NULL)
    {
        BSTree b= new BSTNode;
        b->data.key = key;
        b->lchild=b->rchild = NULL;
    }else{
        if(t->data.key > key){
            Insert_BST(t->lchild, key);
        }else if(t->data.key < key){
            Insert_BST(t->rchild, key);
        }else{
            cout<<"改元素已经在二叉树中"<<endl;
        }
    }
}

void Create_BST(BSTree &t)      //创建二叉排序树
{
    cout<<"键盘录入二叉排序树元素"<<endl;
    char ch;
    cin>>ch;
    while(ch != ENDCHAR)
    {
        Insert_BST(t,ch);
        cin>>ch;
    }
}

BSTree Search_BST(BSTree s,int key)     //二叉排序树查找
{
    if(!s || s->data.key == key){
        return s;
    }else if(s->data.key > key){
        return Search_BST(s->lchild, key);
    }else
        return Search_BST(s->rchild, key);
}

void Delete_BST(BSTree &s,int key)      //二叉排序树删除
{
    //f p q
    // p 含有左右子树
    // p 为头节点
    // p 仅有一个子树
}

#define m 3
typedef struct BTNode{      //B-树
    int keynum; //结点中关键字的个数，即结点的大小
    BTNode *parent;     //指向双亲结点
    int key[m+1];       //关键字矢量，0号单元未用
    BTNode *ptr[m+1];    //子树指针矢量
}BTNode,*BTree;
