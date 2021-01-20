#ifndef CEILINGD_SERVER_H
#define CEILINGD_SERVER_H

#include <thread>
#include <unistd.h>
#include <fstream>
#include <iostream>
#include <Poco/Util/ServerApplication.h>
#include <ServerTask.h>

using namespace Poco;
using namespace Poco::Util;
using namespace std;

class ServerApp : public ServerApplication
{
protected:
    int main(const vector<string> &);
};

#endif //CEILINGD_SERVER_H
