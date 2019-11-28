// /*Arquivo loco.c
//     A ideia do código é visitar os amigos seguindo uma circunferencia para saber se estamos progredindo
//     Traçar uma circunferencia entre o Uoli e o amigo
//     Se Ele(Uoli) caminhar sempre dentro da circunferencia > Estamos progredindo, caso contrário, traçar nova circunferencia
//  */

// #include <math.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include "api_robot.h"

// /*Funções utilizadas*/
// int objeto_detectado();
// void visitar_prox_amigo(Vector3* uoli, Vector3 amigo);

// /*Qualquer ponto dentro da circunferencia, significa que estamos no caminho certo > Progredindo*/
// #define caminho(xi, yi, x, y) (((x-xi)*(x-xi))+((y-yi)*(y-yi)))








// void visitar_prox_amigo(Vector3* uoli, Vector3 amigo){
//     double aux1, aux2, pot1, pot2, soma;
//     double raio, diam;
//     double amigo_area, inimigo_area, progress_area;
//     short objeto;
//     int zero, direcao;
    
    
    
//     aux1 = uoli->x - amigo.x;
//     pot1 = aux1*aux1;
//     aux2 = uoli->y - amigo.y;
//     pot2 = aux2*aux2;
    
//     /*calcular a dist entre o Uoli e o amigo*/
//     soma = pot1 + pot2;
//    //diam = (soma);
//     raio = diam/2;

//     /*Uoli precisa estar dentro do amigo_area pra passar a info, e ainda se manter dentro da zona de progresso*/
//     amigo_area = caminho(amigo.x,amigo.y, uoli->x, uoli->y);
//     progress_area = caminho(aux1, aux2, uoli->x, uoli->y);

// /*Enquanto ele nao se aproximar a 5 metros do amigo, continue andando*/   
//     do{
//         set_torque(50, 50);

//         get_current_GPS_position(uoli);

//     /*DANGEROUS AREAS*/
//         for(int i = 1; i <= sizeof(friends_locations); i++){
//             inimigo_area = caminho(dangerous_locations[i].x, dangerous_locations[i].y, uoli->x, uoli->y);
            
//             /*Para porque estamos no alcance de um inimigo*/
//             if(inimigo_area < 5){
//                 set_torque(0,0);
//             }

//         }
    
//     /*Caso identifique algo se aproximando*/
//     objeto = get_us_distance();
//     /*Precisamos identifcar se é um obstáculo
//         Então olhamos para a esquerda e direita 
//         Se for apenas um obstaculo, ao olhar para os lados, nao teremos nada na leitura do sensor
//         */
//     if(objeto < 6){
//         direcao = objeto_detectado();

//         if(direcao == 1){

//         }
//         else if(direcao == 2){


//         }else{

//         }

        

//     }


//     /*Atualiza pos Uoli e verifica se ele está progredindo*/
//     get_current_GPS_position(uoli);


//     progress_area = caminho(aux1, aux2, uoli->x, uoli->y);

        
//     }while(progress_area <  raio);
//     /*Enquanto estivermos em uma zona de progresso*/

//     return;
// }

// /*É chamada quando percebe que há algo se aproximando
// Uoli então olha para a esquerda e depois direita procurando uma saída, se há
// retorna 2 caso, apenas a direita for válida
// retorna 1 caso, apenas a esquerda for válida
// retorna 0, caso seja um barranco
// */
// int objeto_detectado(){
//     short objeto_esq, objeto_dir;
//     int ok_esq, ok_dir;
//     int flag_esq, flag_dir;
//     int zero = 0;
    
//     /*Girar a cabeça*/
//         /*Verifica se é possível e pede uma leitura do sensor*/
        
//         /*Olha para a esquerda*/
//         ok_esq = set_head_servo(2, 20);
//         if(zero == ok_esq)
//             objeto_esq = get_us_distance();
            
//             /*Verifica se é possível passar
//             se for possível, a flag é sinalizada
//             */
//             if(objeto_esq < 6){
//                 flag_esq = 0;
//             }
//             else
//             {
//                 flag_esq = 1;
//             }
            
//         /*Olha para a direita*/    
//         ok_dir = set_head_servo(2, 136);
//         if(zero == ok_dir)
//             objeto_dir = get_us_distance();
//             /*Verifica se é possível passar
//             se for possível, a flag é sinalizada
//             */
//             if(objeto_esq < 6){
//                 flag_dir = 0;
//             }
//             else
//             {
//                 flag_dir = 1;
//             }

//         /*Após dados coletados, volta a cabeça a posição normal*/

        




//         /*Identica*/
//         /*Apenas esquerda válida*/
//         if(flag_esq == 1 && flag_dir == 0){
//             return 1;
//         }
//         else if(flag_esq == 0 && flag_dir == 1){
//             return 2;
//         }
//         else{
//             return 0;
//         }
// }

// int main(){
//     Vector3 Uoli;

//     /*Até visitar todos os amigos*/
//     for(int i = 1; i <= sizeof(friends_locations)/sizeof(Vector3); i++){
//         /*Pegamos a posição atual do Uoli*/
//         get_current_GPS_position(&Uoli);
        
//         visitar_prox_amigo(&Uoli, friends_locations[i]);
//     }
//     return 0;
// }

#include "api_robot.h"

int main(){
    set_torque(99,99);
    return 0;
}