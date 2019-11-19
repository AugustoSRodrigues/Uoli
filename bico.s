.align 4
# ENGINES
.globl set_torque

.globl set_engine_torque    

.globl set_head_servo
# SENSORS
.globl get_us_distance

.globl get_current_GPS_position

.globl get_gyro_angles

# TIMER
.globl get_time

.globl set_time

# UART
.globl puts


# IMPLEMENTATION ENGINES
set_torque:

    

set_engine_torque:
    li t1, 101
    li t2,-100
    li t3, 0
    li t4, 2
    #Verifica se o torque está dentro do intervalo
    bge a1, t1, fail_torque
    blt a1, t2, fail_torque
    #verifica se o ID é valido
    blt a0, t3, fail_ID 
    bge a0, t4, fail_ID
    li a7, 18
    ecall

    #ele setou os torques
    li a0, 0
    ret
    
    #erro no torque
    fail_torque:
        li a0 -1
        ret
    
    #Erro no ID
    fail_ID:
        li a0, -2
        ret


set_head_servo:
    li t0, 0
    li t1, 1
    li t2, 2

    beq a0, t0, set_base
    beq a0, t1, set_mid
    beq a0, t2, set_top

    #Erro no ID
    li a0, -1
    ret

    
    set_base:
        li t0, 0
        li t1, 157
        j check_angle
        
    set_mid:
        li t0, 52
        li t1, 91
        j check_angle
    
    set_top
        li t0, 16
        li t1, 117
        j check_angle

    check_angle:
        blt a1, t0, fail_angle
        bge a1, t1, fail_angle
        li a7, 17
        ecall
        li a0, 0
        ret

    #Angulo fora do intervalo
    fail_angle:
        li a0, -2
       





#IMPLEMENTATION SENSORS
get_us_distance:
    


get_current_GPS_position:
    li a7, 19
    ecall 

get_gyro_angles:
    li a7, 20
    ecall

# IMPLEMENTATION TIMER
get_time:
    li a7, 21
    ecall
    ret 

set_time:
   #la t0, time_system
    #sw a0, 0(t0)
    #ret
    li a7, 22
    ecall

#IMPLEMENTATION UART
puts: