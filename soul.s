.equ READY_POS_ROT, 0xFFFF0004
.equ POS_X, 0xFFFF0008
.equ POS_Y, 0xFFFF000C
.equ POS_Z, 0xFFFF0010
.equ Angle_Euler, 0xFFFF0014
.equ TORQUE_M2, 0xFFFF0018
.equ TORQUE_M1, 0xFFFF001A
.equ ANGLE_TOP, 0xFFFF001C
.equ ANGLE_MID, 0xFFFF001D
.equ ANGLE_BASE, 0xFFFF001E
.equ READY_SENSOR, 0xFFFF0020
.equ OBJECT_NEAR, 0xFFFF0024
.equ INTERRUPTION_GPT_VALUE, 0xFFFF0100
.equ INTERRUPTION_GPT, 0xFFFF0104
.equ READY_UART_TRANSFER, 0xFFFF0108
.equ UART_TRANSFER_VALUE, 0xFFFF0109
.equ READY_UART_RECEPTION, 0xFFFF010A
.equ UART_RECEPTION_VALUE, 0xFFFF010B	

int_handler:
  ###### Tratador de interrupÃ§Ãµes e syscalls ######
   la a6, salvador_de_registradores
    csrrw a6, mscratch, a7 # troca valor de a0 com mscratch
    sw a1, 0(a6) 
    sw a2, 4(a6)  
    sw a3, 8(a6) 
    sw a4, 12(a6) 
    sw a5, 16(a6) 
    sw a6, 20(a6) 
    sw a7, 24(a6) 
    sw s0, 28(a6) 
    sw s1, 32(a6) 
    sw s2, 36(a6)  
    sw s3, 40(a6) 
    sw s4, 44(a6) 
    sw s5, 48(a6) 
    sw s6, 52(a6)  
    sw s7, 56(a6)  
    sw s8, 60(a6) 
    sw s9, 64(a6)  
    sw s10, 68(a6) 
    sw s11, 72(a6) 
    sw t0, 76(a6) 
    sw t1, 80(a6) 
    sw t2, 84(a6) 
    sw t3, 88(a6)  
    sw t4, 92(a6) 
    sw t5, 96(a6) 
    sw t6, 100(a6) 
    sw zero, 104(a6) 
    sw ra, 108(a6) 
    sw sp, 112(a6) 
    sw gp, 116(a6) 
    sw tp, 120(a6) 

  

  
  # decodifica a causa da interrupção
  csrr a3, mcause # lê a causa da exceção
  bgez a3, exception # desvia se não for uma interrupção

  #verifica se e uma interropcao falsa
  li t0, INTERRUPTION_GPT
  beq t0, zero, tratado_gpt; # if t0 =zero then trata_gpt
  j retorno


  tratado_gpt:
  sb zero, 0(t0)
  j retorno

  




  # <= Implemente o tratamento da sua syscall aqui
  exception:
  li t0, 16
  beq a7, t0, read_ultrasonic_sensor
  li t0, 17 
  beq a7, t0, set_servo_angles
  li t0, 18
  beq a7, t0, set_engine_torque
  li t0, 19
  beq a7, t0, read_gps
  li t0, 20
  beq a7, t0, read_gyroscope
  li t0, 21
  beq a7, t0, get_time
  li t0, 22
  beq a7, t0, set_time
  li t0, 64 
  #beq a7, t0, write
 
  



  read_ultrasonic_sensor:
    li t0,READY_SENSOR
    beq t0, zero, read_ultrasonic_sensor

    li t0, OBJECT_NEAR
    lw a0, 0(t0)
    j retorno
    
  set_servo_angles:
    li t0, 0
    li t1, 1
    li t2, 2

    beq a0, t0, set_base
    beq a0, t1, set_mid
    beq a0, t2, set_top
    #Erro no ID
    li a0, -2
    j retorno

    set_base:
        li t0, 0
        li t1, 157
        li t2 , ANGLE_BASE
        j check_angle
        
    set_mid:
        li t0, 52
        li t1, 91
        li t2, ANGLE_MID
        j check_angle
    
    set_top:
        li t0, 16
        li t1, 117
        li t2, ANGLE_TOP
        j check_angle

    check_angle:
        blt a1, t0, fail_angle
        bge a1, t1, fail_angle

    sw a1, 0(t2)
        
       

    fail_angle:
        li a0, -1
        j retorno
 
 set_engine_torque:
    li t0, 0
    beq a0, t0, set_torque_esq
    li t0, 1
    beq a0, t0, set_torque_dir
    
    #ID invalido
    li a0, -1
    j retorno

    set_torque_esq:
      li t0, TORQUE_M2
      j cont

    set_torque_dir:
      li t0, TORQUE_M1
      j cont
    
    cont:
      sh a1, 0(t0)
      j retorno

  read_gps:
      li t0, READY_POS_ROT
      li t1, 1
      bne t0, t1, read_gps
      
      li t0, POS_X
      li t1, POS_Y
      li t2, POS_Z

      sw t0, 0(a0)
      sw t1, 4(a0)
      sw t2, 8(a0)

      j retorno

  read_gyroscope:
      li t0, READY_POS_ROT
      li t1, 1
      bne t0, t1, read_gyroscope
      li t0, Angle_Euler
      sw t0, 0(a0)
      j retorno

  get_time:
    li t0, INTERRUPTION_GPT_VALUE
    lb a0, 0(t0)
    j retorno

  set_time:
    li t0, INTERRUPTION_GPT_VALUE
    sb a0, 0(t0)
    j retorno
  
  #write:
    

retorno: 
#Recupera Contexto
    lw tp, 120(a6)  
    lw gp, 116(a6) 
    lw sp, 112(a6) 
    lw ra, 108(a6)
    lw zero, 104(a6) 
    lw t6, 100(a6) 
    lw t5, 96(a6) 
    lw t4, 92(a6) 
    lw t3, 88(a6) 
    lw t2, 84(a6) 
    lw t1, 80(a6)  
    lw t0, 76(a6) 
    lw s11, 72(a6) 
    lw s10, 68(a6) 
    lw s9, 64(a6) 
    lw s8, 60(a6)
    lw s7, 56(a6) 
    lw s6, 52(a6) 
    lw s5, 48(a6) 
    lw s4, 44(a6) 
    lw s3, 40(a6)  
    lw s2, 36(a6)  
    lw s1, 32(a6)  
    lw s0, 28(a6)
    lw a7, 24(a6)  
    lw a6, 20(a6) 
    lw a5, 16(a6)  
    lw a4, 12(a6) 
    lw a3, 8(a6)  
    lw a2, 4(a6)  
    lw a1, 0(a6) 

  csrr t0, mepc  # carrega endereÃ§o de retorno (endereÃ§o da instruÃ§Ã£o que invocou a syscall)
  addi t0, t0, 4 # soma 4 no endereÃ§o de retorno (para retornoornar apÃ³s a ecall) 
  csrw mepc, t0  # armazena endereÃ§o de retorno de volta no mepc
  mret           # Recuperar o restante do contexto (pc <- mepc)




# Configuração do sistema (feita durante a operação de reset)
.globl _start
_start:

#<=configuracao inicial aqui
#Configuracao dos servomotores do pescoco
li t0, ANGLE_TOP
li t1, 78
sb t1, 0(t0)
li t0, ANGLE_MID
li t1, 80
sb t1, 0(t0)
li t0, ANGLE_BASE
li t1, 31
sb t1, 0(t0)

#Configuracao do GPT
li t0, INTERRUPTION_GPT_VALUE
li t1, 100
sw t1, 0(t0)

#configiracao do torque 
li t0, TORQUE_M1
sh zero, 0(t0)
li t0, TORQUE_M2
sh zero, 0(t0)


la sp, pilha_usuario


# Configura o tratador de interrupções
la t0, int_handler # Grava o endereço do rótulo int_handler
csrw mtvec, t0 # no registrador mtvec

# Habilita Interrupções Global
csrr t1, mstatus # Seta o bit 7 (MPIE)
ori t1, t1, 0x80 # do registrador mstatus
csrw mstatus, t1

# Habilita Interrupções Externas
csrr t1, mie # Seta o bit 11 (MEIE)
li t2, 0x800 # do registrador mie
or t1, t1, t2
csrw mie, t1

# Ajusta o mscratch
la t1, reg_buffer # Coloca o endereço do buffer para salvar
csrw mscratch, t1 # registradores em mscratch

# Muda para o Modo de usuário
csrr t1, mstatus # Seta os bits 11 e 12 (MPP)
li t2, ~0x1800 # do registrador mstatus
and t1, t1, t2 # com o valor 00
csrw mstatus, t1

la t0, main # Grava o endereço do rótulo user
csrw mepc, t0 # no registrador mepc
mret # PC <= MEPC; MIE <= MPIE; Muda modo para MPP


salvador_de_registradores:
  .skip 124
pilha_usuario:
  .skip 124
UART:
  .skip 12
reg_buffer:
  .skip 12