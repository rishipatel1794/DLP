#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

int checkWord(int n,char word[]){
    for(int i=0;i<n-2;i++){
        if(word[i]!='a'){
            return 0;
        }
    }
    if(word[n-1] == 'b' && word[n-2] == 'b'){
        return 1;
    }
    else{
        return 0;
    }
}

int main(){
    int n;
    printf("Enter the size of word:");
    scanf("%d",&n);
    char word[n];
    printf("Enter the word:");
    scanf("%s",&word);
    if(checkWord(n,word)){
        printf("Valid String!");
    }
    else{
        printf("invalid String!");
    }
    return 0;
}