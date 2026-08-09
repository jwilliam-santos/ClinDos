//Aqui vai Ficar o Codigo Geral Do kernel

void main() {
   
    char* video_memory = (char*) 0xB8000;
    

    video_memory[0] = 'C';       
    video_memory[1] = 0x0A;    

    while(1) {}
}