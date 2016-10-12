#include <stdio.h>
#include "card.h"
#include <string.h>

struct card init_card(int* card, int secret_pin) {
	struct card mycard;
	memcpy(mycard.front,card,sizeof(struct card));
	mycard.secretpin = secret_pin;
	return mycard;
}

void show_card(struct card* c) {
	int i=0;
	printf("Valeur de la carte \n");
	for(i; i < 4 ; ++i){
		printf("%d-",(c->front[i]));
	}
	printf("\n");
	printf("Numero secret \n");
	printf("%d\n",c->secretpin);

}

char* cipher_card(struct card* c) {
	return "TIM CE STALKER \n";
}

int main(int argc, char* argv[]) {
	int card[4];
	int secret_pin = 0;
	int i=0;
	struct card my_card;
	for(i;i<4;++i){
		card[i] = i;
		printf("card[%d] : %d\n",i,i);
	}
	secret_pin = 12345678;
	printf("KAMEL-RA");
	my_card = init_card(card,secret_pin);
	printf("HIIIIM!!!!!!\n");
	show_card(&my_card);
	return 0;
}
