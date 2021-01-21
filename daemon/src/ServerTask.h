#ifndef CEILINGD_SERVERTASK_H
#define CEILINGD_SERVERTASK_H

#include "Poco/Task.h"
#include "Poco/Process.h"
#include "Poco/TaskManager.h"
#include <Poco/Util/ServerApplication.h>
#include <Poco/Util/IniFileConfiguration.h>
#include <Poco/Net/IPAddress.h>
#include <Poco/Net/SocketAddress.h>
#include <Poco/Net/MulticastSocket.h>

#include <modbus.h>

#include "settings.h"

using namespace Poco;
using namespace std;
using namespace Poco::Util;
using namespace Poco::Net;

class ServerTask: public Task, public IniFileConfiguration {
public:
    ServerTask();
    void runTask(void);

    virtual ~ServerTask();

    string getDevice() const;
    int getNumDevices() const;
    int getLedsPerDevice() const;

private:
    SocketAddress sa;
    MulticastSocket sock;
    char buffer[INPUT_BUFFER_SIZE];
    modbus_t *mb;
};

#endif //CEILINGD_SERVERTASK_H
