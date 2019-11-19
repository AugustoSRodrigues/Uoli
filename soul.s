




read_ultrasonic_sensor:



get_time:
    la t0, time_system
    lw t1, 0(t0)
    sw t1, 0(a0)
    ret

time_system:
.skip 4

