#include <ServerTask.h>
#include <iostream>

ServerTask::ServerTask():
        Task(SERVER_TASK_ID),
        IniFileConfiguration(),
        sa(IPAddress(), UDP_PORT),
        sock(sa, true),
        buffer{}
{
  try {
    load(CONFIG_FILE);
  } catch (exception& ignored) {}

  sock.setBlocking(false);
  sock.joinGroup(IPAddress(UDP_MULTICAST_GROUP));
  mb = modbus_new_rtu(getDevice().c_str(), BAUD, 'N', 8, 1);
  modbus_set_response_timeout(mb, 0, 0);
  modbus_set_byte_timeout(mb, 0, 0);
  if (-1 == modbus_connect(mb)) {
    cerr << "Can't connect to device: " << getDevice() << endl;
    modbus_free(mb);
    Poco::Process::requestTermination(Poco::Process::id());
  }
}

ServerTask::~ServerTask() {
  modbus_close(mb);
  modbus_free(mb);
}

void ServerTask::runTask() {
    static uint16_t registers[MAX_LEDS_PER_DEVICE];
    try {
        while (!sleep(POLL_INTERVAL)) {
          while (sock.available()) {
            if (getLedsPerDevice() * getNumDevices() == sock.receiveBytes(buffer, sizeof(buffer) - 1)) {
              for (int device=0; device < getNumDevices(); device++) {
                for (int led = 0; led < getLedsPerDevice(); led++) {
                  registers[led] = buffer[led + device * getLedsPerDevice()];
                }
                modbus_set_slave(mb, device + START_ADDR);
                modbus_write_registers(mb, 0, getLedsPerDevice(), registers);
                modbus_flush(mb);
                sleep(TRANSMIT_DELAY);
              }
            }
          }
        }
    } catch (exception& e) {
        cerr << e.what() << endl;
        Poco::Process::requestTermination(Poco::Process::id());
    }
}

string ServerTask::getDevice() const{
  try {
    return getString("device");
  } catch (exception &e) {
    return DEFAULT_DEVICE;
  }
}

int ServerTask::getNumDevices() const {
  try {
    return getInt("devices");
  } catch (exception &e) {
    return DEFAULT_NUM_DEVICES;
  }
}

int ServerTask::getLedsPerDevice() const {
  try {
    return getInt("leds");
  } catch (exception &e) {
    return DEFAULT_LEDS_PER_DEVICE;
  }
}
