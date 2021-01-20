//
// Created by sl on 05.08.2020.
//

#ifndef CEILINGD_SETTINGS_H
#define CEILINGD_SETTINGS_H

#define SERVER_TASK_ID {'c', 'e', 'i', 'l', 'i', 'n', 'g', 'd'}

#define POLL_INTERVAL 20
#define UDP_PORT 1515
#define UDP_MULTICAST_GROUP "224.0.0.180"
#define INPUT_BUFFER_SIZE 128
#define START_ADDR 1
#define DEFAULT_DEVICE "/dev/ttyS0"
#define DEFAULT_NUM_DEVICES 7
#define DEFAULT_LEDS_PER_DEVICE 6
#define MAX_LEDS_PER_DEVICE 256
#define BAUD 9600
#define TRANSMIT_DELAY 20

#endif //CEILINGD_SETTINGS_H
