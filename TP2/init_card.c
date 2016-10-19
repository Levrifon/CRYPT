#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <openssl/aes.h>
#include <openssl/rand.h>
#include "card.h"

/* AES key for Encryption and Decryption */
const static unsigned char aes_key[]={0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x88,0x99,0xAA,0xBB,0xCC,0xDD,0xEE,0xFF};

struct card init_card(int* card, int secret_pin, char* name) {
	struct card mycard;
	memcpy(mycard.front,card,sizeof(struct card));
	mycard.secretpin = secret_pin;
	mycard.nom = name;
	return mycard;
}

void show_card(struct card* c) {
	int i=0;
	printf("Valeur de la carte : ");
	for(i; i < 4 ; ++i){
			printf("%d",(c->front[i]));
		if(i < 3)
			printf("-");
	}
	printf("\n");
	printf("Numero secret : %d \n",c->secretpin);
	printf("Propriétaire : %s \n",c->nom);

}

char* cipher_card(struct card* c) {
	return "TIM CE STALKER \n";
}


int main(int argc, char* argv[]) {
	int card[4];
	int secret_pin = 0;
	int i=0;
	char* name = "ANUBIS";
	/* Input data to encrypt */
	unsigned char* aes_input="anticonstitutionellement";
	
	/* Init vector */
	unsigned char iv[AES_BLOCK_SIZE];
	memset(iv, 0x00, AES_BLOCK_SIZE);
	
	/* Buffers for Encryption and Decryption */
	unsigned char enc_out[sizeof(aes_input)];
	unsigned char dec_out[sizeof(aes_input)];
	
	/* AES-128 bit CBC Encryption */
	AES_KEY enc_key, dec_key;
	AES_set_encrypt_key(aes_key, sizeof(aes_key)*8, &enc_key);
	AES_cbc_encrypt(aes_input, enc_out, sizeof(aes_input), &enc_key, iv, AES_ENCRYPT);
	/* AES-128 bit CBC Decryption */
	memset(iv, 0x00, AES_BLOCK_SIZE); // don't forget to set iv vector again, else you can't decrypt data properly
	AES_set_decrypt_key(aes_key, sizeof(aes_key)*8, &dec_key); // Size of key is in bits
	AES_cbc_encrypt(enc_out, dec_out, sizeof(aes_input), &dec_key, iv, AES_DECRYPT);
	
	printf("Encrypted %s \n",enc_out);
	
	printf("Decrypted %s \n",dec_out);
	
	return 0;
}
