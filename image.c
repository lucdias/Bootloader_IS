#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
    FILE *color,*bin,*ima;
    int w,j,k,l,i,cont=0;
    int r,d,cores[22]={0x0,0x8,0x4,0x6,0xe,0x2,0xb,0x1,0xd,0xc,0xa,0xf,0x7,0x4,0x6,0xe,0x2,0x9,0x1,0x5,0x9,0xe};
    int matriz[80][3],colorBMP[22][3];
    char arquivo[40],copy[40];

    printf("Apenas o nome do arquivo BMP 24 cores: ");
    scanf(" %s",arquivo);
    strcpy(copy,arquivo);
    strcat(arquivo,".bmp");
    strcat(copy,".bin");
    color=fopen("cores.bmp", "rb"); 
    if (color == NULL){
    	printf("Erro, arquivo nao encontrado\n");
    	return 0;
    }
    ima=fopen(arquivo,"rb");
    if (ima == NULL){
    	printf("Erro, arquivo nao encontrado\n");
    	return 0;
    }
    bin=fopen(copy, "wb");

    if(color!=NULL){
        for(k=0;k<54;k++){
            fgetc(color);
        }
        for(k=0;k<22;k++){
            for(cont =0;cont <3;cont ++){   
                d=fgetc(color);
                colorBMP[k][cont]=d;
            }
        }
    }
    if(ima!=NULL){
        for(k=0;k<54;k++){
            fgetc(ima);
        }
        for(k=0;k<80;k++){
            for(cont =0;cont <3;cont ++){   
                d=fgetc(ima);
                matriz[k][cont]=d;
            }
        }
    }
    for(k=0;k<80;k++){
        for(cont =0;cont <22;cont ++){   
            if(matriz[k][0] == colorBMP[cont][0] && matriz[k][1] == colorBMP[cont][1] && matriz[k][2] == colorBMP[cont][2]){
            	fputc(cores[cont],bin);
            	cont=23;
            }
        }
    }
    fclose(ima);
    fclose(color);
    fclose(bin);
	return 0;
}