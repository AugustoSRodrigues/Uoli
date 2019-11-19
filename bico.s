# ENGINES
.globl set_torque

.globl set_engine_torque    

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
    li t1, 100
    li t2, -100
    bgt a1, t1, fail
    blt a1, t2, fail
    li a7, 18
    ecall

    #ele setou os torques
    li a0, 0
    ret
    
    fail:
        li a0 -1
        ret


get_us_distance:

#IMPLEMENTATION SENSORS
get_current_GPS_position:

get_gyro_angles:

# IMPLEMENTATION TIMER
get_time:
    li a7, 21
    ecall
    
    la t0, time_system
    lw t1, 0(t0)
    sw t1, 0(a0)
    ret

set_time:
    la t0, time_system
    sw a0, 0(t0)
    ret

#IMPLEMENTATION UART
puts: